import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  late User user;
  late String displayName;
  late String username;
  late String? photoUrl;
  late String? coverPhotoUrl;
  late String bio;
  late String? location;
  late String joiningDate;

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
}
