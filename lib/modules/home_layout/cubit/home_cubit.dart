import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:http/http.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/models/cloud_message.dart';
import 'package:nexus/models/message.dart';
import 'package:nexus/models/post.dart';
import 'package:nexus/models/post_author.dart';
import 'package:nexus/models/notification.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/shared/date_time_helper.dart';
import 'package:nexus/shared/network/remote/firebase_cloud_messaging_manager.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';
import 'package:nexus/shared/network/remote/supabase_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState()) {
    if (state is HomeInitialState) {
      getUserProfile();
      getPosts();
      getAllUsers();
    }
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  UserProfile? userProfile;
  File? avatarPhotoFile;
  File? coverPhotoFile;
  List<Post> postsList = [];
  List<UserProfile> allUsersList = [];
  bool messagesLoadingTriggered = false;
  List<Message> messagesList = [];
  List<UserProfile> chatUserProfilesList = [];
  bool notificationsLoadingTriggered = false;
  List<Notification> notificationsList = [];

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }

  UserProfile? getUserProfile({String? updateStatus}) {
    emit(ProfileGetLoadingState());

    if (userProfile != null && updateStatus == null) {
      emit(ProfileGetSuccessState(userProfile!));
      return userProfile!;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'Error happened while getting firebase user';
    }

    FirestoreManager.getUserProfile(user.uid)
        .then((value) {
          userProfile = UserProfile.fromMap(user: user, json: value.data()!);
          emit(ProfileGetSuccessState(userProfile!));
          return userProfile!;
        })
        .catchError((error) {
          String errorMsg = 'Error happened while getting user profile: $error';
          emit(ProfileGetErrorState(errorMessage: errorMsg));
          throw errorMsg;
        });
    return userProfile;
  }

  void updateUserProfile(UserProfile newProfile) async {
    emit(ProfileUpdateLoadingState());

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'null user';
    }

    if (avatarPhotoFile != null) {
      await uploadAvatarPhoto();
      newProfile.photoUrl = userProfile!.photoUrl;
    }
    if (coverPhotoFile != null) {
      await uploadCoverPhoto();
      newProfile.coverPhotoUrl = userProfile!.coverPhotoUrl;
    }

    // TODO: uncomment this when the respective use case is created
    // FirestoreManager.updateUserProfile(newProfile)
    //     .then((value) {
    //       userProfile = newProfile;
    //       emit(ProfileUpdateSuccessState(userProfile!));
    //     })
    //     .catchError((error) {
    //       emit(
    //         ProfileUpdateErrorState(
    //           errorMessage:
    //               'Error happened while updating user profile: $error',
    //         ),
    //       );
    //     });
  }

  void pickUserAvatarPhoto() async {
    emit(AvatarPhotoPickLoadingState());
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      emit(AvatarPhotoPickSuccessState());
      avatarPhotoFile = File(result.files.single.path!);
    } else {
      emit(AvatarPhotoPickErrorState(errorMessage: 'user canceled the picker'));
    }
  }

  void pickUserCoverPhoto() async {
    emit(CoverPhotoPickLoadingState());
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      emit(CoverPhotoPickSuccessState());
      coverPhotoFile = File(result.files.single.path!);
    } else {
      emit(CoverPhotoPickErrorState(errorMessage: 'user canceled the picker'));
    }
  }

  Future uploadAvatarPhoto() {
    emit(PhotoUploadLoadingState());

    return SupabaseManager.uploadFile(avatarPhotoFile!, usersAvatarsDirectory)
        .then((value) {
          emit(PhotoUploadSuccessState());
          String photoUrl = SupabaseManager.getPublicUrl(
            avatarPhotoFile!,
            usersAvatarsDirectory,
          );
          userProfile?.photoUrl = photoUrl;
        })
        .catchError((error) {
          emit(
            PhotoUploadErrorState(
              errorMessage:
                  'Error happened while uploading avatar photo: $error',
            ),
          );
        });
  }

  Future uploadCoverPhoto() {
    emit(PhotoUploadLoadingState());

    return SupabaseManager.uploadFile(coverPhotoFile!, usersCoversDirectory)
        .then((value) {
          emit(PhotoUploadSuccessState());
          String photoUrl = SupabaseManager.getPublicUrl(
            coverPhotoFile!,
            usersCoversDirectory,
          );
          userProfile?.coverPhotoUrl = photoUrl;
        })
        .catchError((error) {
          emit(
            PhotoUploadErrorState(
              errorMessage:
                  'Error happened while uploading cover photo: $error',
            ),
          );
        });
  }

  void createPost(Post post) {
    emit(PostCreationLoadingState());
    FirestoreManager.createPost(post)
        .then((value) async {
          PostAuthor author = await getPostAuthor(userProfile!.user.uid);
          post.postAuthor = author;
          post.uid = value.id;
          emit(PostCreationSuccessState());
        })
        .catchError((error) {
          emit(
            PostCreationErrorState(
              errorMessage: 'Error happened while creating post: $error',
            ),
          );
        });
  }

  void getPosts() {
    emit(PostsGetLoadingState());
    FirestoreManager.getPostsDocs()
        .then((value) async {
          for (QueryDocumentSnapshot doc in value.docs) {
            Post post = Post.fromMap(doc.data() as Map<String, dynamic>);
            PostAuthor author = await getPostAuthor(doc.get('authorUid'));
            post.postAuthor = author;
            post.uid = doc.id;
            List<dynamic> likesList = doc.get('likesList');
            post.isLiked = likesList.contains(userProfile!.user.uid);
            postsList.add(post);
          }
          emit(PostsGetSuccessState());
        })
        .catchError((error) {
          emit(
            PostsGetErrorState(
              errorMessage: 'Error happened while creating post: $error',
            ),
          );
        });
  }

  Future<PostAuthor> getPostAuthor(String authorUid) async {
    emit(PostAuthorGetLoadingState());

    DocumentSnapshot<Map<String, dynamic>>? docSnap =
        await FirestoreManager.getUserProfile(authorUid).catchError((error) {
          emit(
            PostAuthorGetErrorState(
              errorMessage:
                  'Error happened while getting post author data: $error',
            ),
          );
          throw error;
        });

    emit(PostAuthorGetSuccessState());
    return PostAuthor(
      uid: docSnap.id,
      displayName: docSnap.get('displayName'),
      photoUrl: docSnap.get('photoUrl'),
      fcmToken: docSnap.get('fcmToken'),
    );
  }

  void likePost(Post post) {
    emit(PostLikeLoadingState());

    FirestoreManager.submitPostLike(
          post.uid,
          userProfile!.user.uid,
          post.isLiked,
        )
        .then((value) async {
          // modify local version instead of fetching remote
          if (post.isLiked) {
            postsList[postsList.indexOf(post)].likesList.remove(
              userProfile!.user.uid,
            );
          } else {
            postsList[postsList.indexOf(post)].likesList.add(
              userProfile!.user.uid,
            );
            // Send notification to post author (if not you)
            if (userProfile!.user.uid == post.postAuthor.uid) return;
            CloudMessage cloudMessage = CloudMessage.withToken(
              data: {
                "type": CloudMessageType.postLike.name,
                "senderUid": userProfile!.user.uid,
                "postUid": post.uid,
                "dateTime": DateTimeHelper.getCurrentDateTime(),
              },
              notificationData: NotificationData(
                title: "${userProfile!.displayName} Liked Your Post",
                body:
                    "Your post seems to get ${userProfile!.displayName}'s attention",
              ),
              token: post.postAuthor.fcmToken,
            );
            Response response = await sendNotification(cloudMessage);
            Map<String, dynamic> responseMap = jsonDecode(response.body);
            Notification notification = Notification(
              name: responseMap['name'],
              cloudMessage: cloudMessage,
              senderUid: userProfile!.user.uid,
              sendDate: DateTimeHelper.getCurrentDateTime(),
            );
            await saveNotification(notification, post.postAuthor.uid);
          }
          postsList[postsList.indexOf(post)].isLiked = !post.isLiked;
          emit(PostLikeSuccessState());
        })
        .catchError((error) {
          emit(
            PostLikeErrorState(
              errorMessage: 'Error happened while submitting post like: $error',
            ),
          );
        });
  }

  void getAllUsers() {
    emit(AllUsersGetLoadingState());

    if (allUsersList.isNotEmpty) {
      emit(AllUsersGetSuccessState());
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'Error happened while getting firebase user';
    }

    FirestoreManager.getAllUsers()
        .then((value) {
          // TODO: Test the remove function here. It may not be working.
          // value.docs.removeWhere(
          //   (element) => (element.id == userProfile!.user.uid),
          // );
          value.docs.forEach(
            (element) => allUsersList.add(
              UserProfile.other(
                uid: element.id,
                photoUrl: element.data()['photoUrl'],
                displayName: element.data()['displayName'],
                bio: element.data()['bio'],
              ),
            ),
          );
          emit(AllUsersGetSuccessState());
          return;
        })
        .catchError((error) {
          emit(
            AllUsersGetErrorState(
              errorMessage: 'Error happened while getting all users: $error',
            ),
          );
        });
  }

  void sendMessage(String receiverUid, Message message) {
    emit(ChatMessagesSendLoadingState());

    FirestoreManager.createMessage(message, userProfile!.user.uid, receiverUid)
        .then((value) {
          emit(ChatMessagesSendSuccessState());
        })
        .catchError((error) {
          emit(
            ChatMessagesSendErrorState(
              errorMessage: 'Error happened while creating a message: $error',
            ),
          );
        });
  }

  void getChatMessages(String receiverUid) {
    emit(ChatMessagesGetLoadingState());

    FirestoreManager.getMessages(userProfile!.user.uid, receiverUid).listen(
      (event) {
        event.docChanges.forEach((change) {
          // TODO: Modify this after adding editing/removing functionalities
          if (change.type == DocumentChangeType.added) {
            messagesList.add(Message.fromMap(change.doc.data()!));
          }
        });
        emit(ChatMessagesGetSuccessState());
      },
      onError: (error) {
        emit(
          ChatMessagesGetErrorState(
            errorMessage:
                'Error happened while reading messages stream: $error',
          ),
        );
      },
    );
  }

  void getChatProfiles() {
    if (chatUserProfilesList.isNotEmpty) {
      return;
    }

    emit(ChatsProfilesGetLoadingState());

    FirestoreManager.getChatsForUser(userProfile!.user.uid).then(
      (value) async {
        for (DocumentSnapshot doc in value.docs) {
          DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
              await FirestoreManager.getUserProfile(doc.id);
          chatUserProfilesList.add(
            UserProfile.forChat(
              uid: profileSnapshot.id,
              photoUrl: profileSnapshot.data()!['photoUrl'],
              displayName: profileSnapshot.data()!['displayName'],
              fcmToken: FirebaseCloudMessagingManager.fcmToken,
            ),
          );
          // Emit after populating the list
          if (value.docs.last.id == doc.id) {
            emit(ChatsProfilesGetSuccessState());
          }
        }
      },
      onError: (error) {
        emit(
          ChatsProfilesGetErrorState(
            errorMessage:
                'Error happened while getting chats user profiles: $error',
          ),
        );
      },
    );
  }

  Future<Response> sendNotification(CloudMessage message) async {
    // TODO: modify this to add states
    // emit(NotificationsSendLoadingState());
    return FirebaseCloudMessagingManager.sendNotification(message: message);
    // .then((value) {
    //   emit(NotificationsSendSuccessState());
    //   // return value;
    // })
    // .catchError((error) {
    //   emit(
    //     NotificationsSendErrorState(
    //       errorMessage:
    //           "Error occurred while sending a notification: $error",
    //     ),
    //   );
    // });
  }

  void getNotificationsHistory() {
    if (notificationsList.isNotEmpty) {
      return;
    }

    emit(NotificationsGetLoadingState());

    FirestoreManager.getNotifications(userProfile!.user.uid).then(
      (value) async {
        for (DocumentSnapshot doc in value.docs) {
          Notification notification = Notification.fromMap(
            doc.data() as Map<String, dynamic>,
          );
          notification.id = doc.id;
          notificationsList.add(notification);
          // Emit after populating the list
          if (value.docs.last.id == doc.id) {
            emit(NotificationsGetSuccessState());
          }
        }
      },
      onError: (error) {
        emit(
          NotificationsGetErrorState(
            errorMessage:
                'Error happened while getting user notifications: $error',
          ),
        );
      },
    );
  }

  Future<void> saveNotification(Notification notification, String receiverUid) {
    emit(NotificationSaveLoadingState());

    return FirestoreManager.saveNotification(notification, receiverUid).then(
      (value) => emit(NotificationSaveSuccessState()),
      onError: (error) {
        emit(
          NotificationSaveErrorState(
            errorMessage:
                'Error happened while saving notification to history: $error',
          ),
        );
      },
    );
  }
}
