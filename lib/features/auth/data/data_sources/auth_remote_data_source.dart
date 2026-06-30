import '../models/user_credential_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredentialModel> loginUser({
    required String email,
    required String password,
  });
}
