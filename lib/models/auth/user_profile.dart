import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  // Remote
  late User user; // Stored in Firebase Auth
  late String displayName;
  late String username;
  late String? photoUrl;
  late String? coverPhotoUrl;
  late String bio;
  late String? location;
  late String joiningDate;
  late String fcmToken;

  // Local
  late String uid;

  UserProfile({
    required this.user,
    required this.displayName,
    required this.username,
    required this.photoUrl,
    required this.coverPhotoUrl,
    required this.bio,
    required this.location,
    required this.joiningDate,
    required this.fcmToken,
  });

  UserProfile.fromMap({
    required this.user,
    required Map<String, dynamic> json,
  }) {
    displayName = json['displayName'];
    username = json['username'];
    photoUrl = json['photoUrl'];
    coverPhotoUrl = json['coverPhotoUrl'];
    bio = json['bio'];
    location = json['location'];
    joiningDate = json['joiningDate'];
    fcmToken = json['fcmToken'];
  }

  UserProfile.copy({required UserProfile oldProfile}) {
    user = oldProfile.user;
    displayName = oldProfile.displayName;
    username = oldProfile.username;
    photoUrl = oldProfile.photoUrl;
    coverPhotoUrl = oldProfile.coverPhotoUrl;
    bio = oldProfile.bio;
    location = oldProfile.location;
    joiningDate = oldProfile.joiningDate;
    fcmToken = oldProfile.fcmToken;
  }

  // To show other profiles
  UserProfile.other({
    required this.uid,
    required this.photoUrl,
    required this.displayName,
    required this.bio,
  });

  // To show chat profiles
  UserProfile.forChat({
    required this.uid,
    required this.photoUrl,
    required this.displayName,
    required this.fcmToken,
  });

  UserProfile update({
    User? user,
    String? displayName,
    String? username,
    String? photoUrl,
    String? coverPhotoUrl,
    String? bio,
    String? location,
    String? joiningDate,
    String? fcmToken,
  }) {
    UserProfile newProfile = UserProfile.copy(oldProfile: this);
    newProfile.user = user ?? newProfile.user;
    newProfile.displayName = displayName ?? newProfile.displayName;
    newProfile.username = username ?? newProfile.username;
    newProfile.photoUrl = photoUrl ?? newProfile.photoUrl;
    newProfile.coverPhotoUrl = coverPhotoUrl ?? newProfile.coverPhotoUrl;
    newProfile.bio = bio ?? newProfile.bio;
    newProfile.location = location ?? newProfile.location;
    newProfile.joiningDate = joiningDate ?? newProfile.joiningDate;
    newProfile.fcmToken = fcmToken ?? newProfile.fcmToken;

    return newProfile;
  }

  bool isDifferent(UserProfile other) {
    if (user != other.user ||
        displayName != other.displayName ||
        username != other.username ||
        photoUrl != other.photoUrl ||
        coverPhotoUrl != other.coverPhotoUrl ||
        bio != other.bio ||
        location != other.location ||
        joiningDate != other.joiningDate ||
        fcmToken != other.fcmToken
    ) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'photoUrl': photoUrl,
      'coverPhotoUrl': coverPhotoUrl,
      'bio': bio,
      'location': location,
      'joiningDate': joiningDate,
      'fcmToken': fcmToken,
    };
  }
}
