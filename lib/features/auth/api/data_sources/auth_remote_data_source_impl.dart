import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus/features/auth/api/client/firebase_auth_client.dart';
import 'package:nexus/features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../data/models/user_credential_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuthClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserCredentialModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _client.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('User was not found in Firebase');
      }

      return UserCredentialModel(userCredential);
    } on Exception catch (e) {
      throw Exception('Authentication Failed. Error: ${e.toString()}');
    }
  }
}
