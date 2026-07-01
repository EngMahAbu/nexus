import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthRepository {
  Future<UserCredentialEntity> loginUser({
    required String email,
    required String password,
  });

  Future<UserProfileEntity> createUser({
    required String name,
    required String email,
    required String password,
  });
}
