import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

// this client wraps firebase so it can be mocked (for unit testing) or configured
@injectable
class FirebaseAuthClient {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthClient() : _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get instance => _firebaseAuth;
}
