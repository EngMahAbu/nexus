// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/api/client/firebase_auth_client.dart' as _i69;
import '../../features/auth/api/data_sources/auth_local_data_source_impl.dart'
    as _i678;
import '../../features/auth/api/data_sources/auth_remote_data_source_impl.dart'
    as _i405;
import '../../features/auth/data/data_sources/auth_local_data_source.dart'
    as _i606;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/register_use_case.dart' as _i1010;
import '../../features/auth/presentation/viewmodel/auth_cubit.dart' as _i261;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i69.FirebaseAuthClient>(() => _i69.FirebaseAuthClient());
    gh.lazySingleton<_i606.AuthLocalDataSource>(
      () => _i678.AuthLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i25.AuthRemoteDataSource>(
      () => _i405.AuthRemoteDataSourceImpl(gh<_i69.FirebaseAuthClient>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i25.AuthRemoteDataSource>(),
        gh<_i606.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1038.LoginUseCase>(
      () => _i1038.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i1010.RegisterUseCase>(
      () => _i1010.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i261.AuthCubit>(
      () => _i261.AuthCubit(
        gh<_i1038.LoginUseCase>(),
        gh<_i1010.RegisterUseCase>(),
      ),
    );
    return this;
  }
}
