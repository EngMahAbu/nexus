import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';

abstract class AuthRepository {
  Future<UserCredentialEntity> loginUser({required String email, required String password});
}
