import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus/models/message.dart';
import 'package:nexus/models/notification.dart';
import 'package:nexus/models/post.dart';


class FirestoreManager {
  // User Profile Utilities
  // static Future<void> updateUserProfile(UserProfile profile) {
  //   return FirebaseFirestore.instance
  //       .collection('UserProfiles')
  //       .doc(profile.user.uid)
  //       .set(profile.toMap());
  // }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
    String userId,
  ) {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(userId)
        .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return FirebaseFirestore.instance.collection('UserProfiles').get();
  }

  // Post Utilities
  static Future<DocumentReference<Map<String, dynamic>>> createPost(Post post) {
    return FirebaseFirestore.instance.collection('Posts').add(post.toMap());
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPostsDocs() {
    return FirebaseFirestore.instance.collection('Posts').get();
  }

  static Future<void> submitPostLike(
    String postUid,
    String userUid,
    bool isLiked,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> docSnap = await FirebaseFirestore
        .instance
        .collection('Posts')
        .doc(postUid)
        .get();
    List<dynamic> list = docSnap.get('likesList');
    isLiked ? list.remove(userUid) : list.add(userUid);
    return FirebaseFirestore.instance.collection('Posts').doc(postUid).update({
      'likesList': list,
    });
  }

  // Chat Utilities
  static Future<void> createChatPathIfNotExist(
    String senderUid,
    String receiverUid,
  ) {
    FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(senderUid)
        .collection('Chats')
        .doc(receiverUid)
        .set({'Messages': []}, SetOptions(merge: true));

    // Receiver version
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(receiverUid)
        .collection('Chats')
        .doc(senderUid)
        .set({}, SetOptions(merge: true));
  }

  static Future<DocumentReference<Map<String, dynamic>>> createMessage(
    Message message,
    String senderUid,
    String receiverUid,
  ) async {
    // Check for Non-existent parent documents [Firebase Terms]
    await createChatPathIfNotExist(senderUid, receiverUid);

    // Sender version
    FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(senderUid)
        .collection('Chats')
        .doc(receiverUid)
        .collection('Messages')
        .add(message.toMap());

    // Receiver version
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(receiverUid)
        .collection('Chats')
        .doc(senderUid)
        .collection('Messages')
        .add(message.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String senderUid,
    String receiverUid,
  ) {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(senderUid)
        .collection('Chats')
        .doc(receiverUid)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getChatsForUser(
    String userUid,
  ) {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(userUid)
        .collection('Chats')
        .get();
  }

  // Notifications Utilities
  static Future<DocumentReference<Map<String, dynamic>>> saveNotification(
    Notification notification,
    String receiverUid,
  ) async {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(receiverUid)
        .collection('Notifications')
        .add(notification.toMap());
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getNotifications(
    String userUid,
  ) {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(userUid)
        .collection('Notifications')
        .orderBy('sendDate')
        .get();
  }
}
