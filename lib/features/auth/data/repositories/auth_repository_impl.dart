import 'package:nexus/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<UserCredentialEntity> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredentialModel = await _authRemoteDataSource.loginUser(email: email, password: password);
    return userCredentialModel.toEntity();
  }
}
