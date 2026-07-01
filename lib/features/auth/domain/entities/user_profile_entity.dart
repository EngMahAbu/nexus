class UserProfileEntity {
  // user fields
  final String uid;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoUrl;
  final String? refreshToken;

  // Remote
  final String username;
  final String? coverPhotoUrl;
  final String bio;
  final String? location;
  final String joiningDate;
  final String fcmToken;

  // // Local
  // final String uid;

  UserProfileEntity({
    required this.uid,
    this.displayName,
    this.email,
    required this.emailVerified,
    this.phoneNumber,
    this.photoUrl,
    this.refreshToken,
    required this.username,
    this.coverPhotoUrl,
    required this.bio,
    this.location,
    required this.joiningDate,
    required this.fcmToken,
  });
}
