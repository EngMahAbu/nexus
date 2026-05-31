import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/models/message.dart';
import 'package:nexus/models/post.dart';

// const String

class FirestoreManager {
  // User Profile Utilities
  static Future<void> updateUserProfile(UserProfile profile) {
    return FirebaseFirestore.instance
        .collection('UserProfiles')
        .doc(profile.user.uid)
        .set({
          'displayName': profile.displayName,
          'username': profile.username,
          'photoUrl': profile.photoUrl,
          'coverPhotoUrl': profile.coverPhotoUrl,
          'bio': profile.bio,
          'location': profile.location,
          'joiningDate': profile.joiningDate,
        });
  }

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
  static Future<DocumentReference<Map<String, dynamic>>> createMessage(
    Message message,
    String senderUid,
    String receiverUid,
  ) {
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
}
