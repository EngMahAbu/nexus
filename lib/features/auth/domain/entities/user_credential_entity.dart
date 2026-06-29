class UserCredentialEntity {
  // credential fields
  final int? token;
  final String? accessToken;
  final String providerId;
  final String signInMethod;

  // user fields
  final String uid;
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoURL;
  final String? refreshToken;

  UserCredentialEntity({
    required this.token,
    required this.accessToken,
    required this.providerId,
    required this.signInMethod,
    required this.uid,
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
    required this.photoURL,
    required this.refreshToken,
  });
}
