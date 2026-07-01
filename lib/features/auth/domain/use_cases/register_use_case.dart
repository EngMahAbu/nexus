import 'package:injectable/injectable.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<UserProfileEntity> call({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final profile = await _authRepository.createUser(
        name: name,
        email: email,
        password: password,
      );
      return profile;
    } on Exception catch (e) {
      throw Exception('Error happened while registering user: ${e.toString()}');
    }
  }
}
