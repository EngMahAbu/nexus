import 'package:firebase_auth/firebase_auth.dart';

// Error Codes
const String emailUsed = 'email-already-in-use';
const String invalidEmail = 'invalid-email';
const String weakPassword = 'weak-password';
const String networkFailure = 'network-request-failed';
// Error Response Messages
const String emailUsedResponse = 'Email is already used, try a different one.';
const String invalidEmailResponse = 'Invalid email format.';
const String weakPasswordResponse =
    'This password is weak, use a hard combination of numbers and symbols.';
const String networkFailureResponse =
    'Network error occurred, check your internet connection.';

class FirebaseAuthManager {

  static Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
