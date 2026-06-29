import 'package:firebase_auth/firebase_auth.dart';

// this client wraps firebase so it can be mocked (for unit testing) or configured
class FirebaseAuthClient {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthClient() : _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get instance => _firebaseAuth;
}
