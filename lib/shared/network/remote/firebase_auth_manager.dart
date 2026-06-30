import 'package:firebase_auth/firebase_auth.dart';

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

  // static Future<UserCredential> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   return FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  static Future<void> updateDisplayName(String name) async {
    return await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  }
}
