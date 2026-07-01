import 'package:nexus/features/auth/data/models/user_profile_model.dart';
import '../models/user_credential_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredentialModel> createUser({
    required String email,
    required String password,
  });

  Future<UserCredentialModel> loginUser({
    required String email,
    required String password,
  });

  Future<void> updateDisplayName({required String name});

  Future<void> updateUserProfile({required UserProfileModel profile});
}
