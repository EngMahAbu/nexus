import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  // Remote
  late User user;
  late String displayName;
  late String username;
  late String? photoUrl;
  late String? coverPhotoUrl;
  late String bio;
  late String? location;
  late String joiningDate;

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
  }

  // To show other profiles
  UserProfile.other({
    required this.uid,
    required this.photoUrl,
    required this.displayName,
    required this.bio,
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
        joiningDate != other.joiningDate) {
      return true;
    }
    return false;
  }
}
