import 'package:nexus/core/contansts/app_constants.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';

class UserProfileModel {
  // user fields
  final String uid;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoUrl;
  final String? refreshToken;

  // Remote
  // final User user; // Stored in Firebase Auth
  // final String displayName;
  final String username;

  // final String? photoUrl;
  final String? coverPhotoUrl;
  final String bio;
  final String? location;
  final String joiningDate;
  final String fcmToken;

  // // Local
  // final String uid;

  UserProfileModel({
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

  Map<String, dynamic> toFirestore() {
    return {
      AppConstants.profileDisplayName: displayName,
      AppConstants.profileUsername: username,
      AppConstants.profilePhotoUrl: photoUrl,
      AppConstants.profileCoverPhotoUrl: coverPhotoUrl,
      AppConstants.profileBio: bio,
      AppConstants.profileLocation: location,
      AppConstants.profileJoiningDate: joiningDate,
      AppConstants.profileFcmToken: fcmToken,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      uid: uid,
      displayName: displayName,
      email: email,
      emailVerified: emailVerified,
      phoneNumber: phoneNumber,
      photoUrl: photoUrl,
      refreshToken: refreshToken,
      username: username,
      coverPhotoUrl: coverPhotoUrl,
      bio: bio,
      location: location,
      joiningDate: joiningDate,
      fcmToken: fcmToken,
    );
  }

  // UserProfileModel(UserCredential userCredential)
  //   : token = userCredential.credential!.token,
  //     accessToken = userCredential.credential!.accessToken,
  //     providerId = userCredential.credential!.providerId,
  //     signInMethod = userCredential.credential!.signInMethod,
  //     uid = userCredential.user!.uid,
  //     displayName = userCredential.user!.displayName,
  //     email = userCredential.user!.email,
  //     emailVerified = userCredential.user!.emailVerified,
  //     phoneNumber = userCredential.user!.phoneNumber,
  //     photoURL = userCredential.user!.photoURL,
  //     refreshToken = userCredential.user!.refreshToken;

  // UserCredentialEntity toEntity() => UserCredentialEntity(
  //   token: token,
  //   accessToken: accessToken,
  //   providerId: providerId,
  //   signInMethod: signInMethod,
  //   uid: uid,
  //   displayName: displayName,
  //   email: email,
  //   emailVerified: emailVerified,
  //   phoneNumber: phoneNumber,
  //   photoURL: photoURL,
  //   refreshToken: refreshToken,
  // );
}
