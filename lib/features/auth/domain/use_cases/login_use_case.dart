import 'package:injectable/injectable.dart';
import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<UserCredentialEntity> call({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authRepository.loginUser(
        email: email,
        password: password,
      );
      return credential;
    } on Exception catch (e) {
      throw Exception(
        'Error happened while logging user or caching token: ${e.toString()}',
      );
    }
  }
}
