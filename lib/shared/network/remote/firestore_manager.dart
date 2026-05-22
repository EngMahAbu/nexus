import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexus/models/auth/user_profile.dart';

// const String

class FirestoreManager {
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
}
