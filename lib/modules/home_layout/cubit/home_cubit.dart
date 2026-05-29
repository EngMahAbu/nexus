import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/models/post.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';
import 'package:nexus/shared/network/remote/supabase_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState()) {
    if (state is HomeInitialState) {
      getUserProfile();
      getPosts();
    }
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  UserProfile? userProfile;
  File? avatarPhotoFile;
  File? coverPhotoFile;
  List<Post> postsList = [];

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

    FirestoreManager.updateUserProfile(newProfile)
        .then((value) {
          userProfile = newProfile;
          emit(ProfileUpdateSuccessState(userProfile!));
        })
        .catchError((error) {
          emit(
            ProfileUpdateErrorState(
              errorMessage:
                  'Error happened while updating user profile: $error',
            ),
          );
        });
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
        .then((value) {
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
        .then((value) {
          for (QueryDocumentSnapshot doc in value.docs) {
            postsList.add(Post.fromMap(doc.data() as Map<String, dynamic>));
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
}
