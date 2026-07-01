import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';

class UserCredentialModel {
  // credential fields
  final int? token;
  final String? accessToken;

  // user fields
  final String uid;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoURL;
  final String? refreshToken;

  UserCredentialModel(UserCredential userCredential)
    : token = userCredential.credential?.token,
      accessToken = userCredential.credential?.accessToken,
      uid = userCredential.user!.uid,
      displayName = userCredential.user!.displayName,
      email = userCredential.user!.email,
      emailVerified = userCredential.user!.emailVerified,
      phoneNumber = userCredential.user!.phoneNumber,
      photoURL = userCredential.user!.photoURL,
      refreshToken = userCredential.user!.refreshToken;

  UserCredentialEntity toEntity() => UserCredentialEntity(
    token: token,
    accessToken: accessToken,
    uid: uid,
    displayName: displayName,
    email: email,
    emailVerified: emailVerified,
    phoneNumber: phoneNumber,
    photoURL: photoURL,
    refreshToken: refreshToken,
  );
}
