import 'package:injectable/injectable.dart';
import 'package:nexus/core/contansts/app_constants.dart';
import 'package:nexus/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUserUid({required String uid}) async {
    return await SharedPreferencesHelper.setData(
      AppConstants.cacheUserUidKey,
      uid,
    );
  }
}
