import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nexus/core/contansts/app_constants.dart';
import 'package:nexus/core/contansts/app_strings.dart';
import 'package:nexus/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:nexus/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:nexus/features/auth/data/models/user_profile_model.dart';
import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';
import 'package:nexus/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<UserProfileEntity> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredentialModel = await _authRemoteDataSource.createUser(
      email: email,
      password: password,
    );

    UserProfileModel userProfileModel = UserProfileModel(
      uid: userCredentialModel.uid,
      displayName: name,
      email: userCredentialModel.email,
      emailVerified: userCredentialModel.emailVerified,
      phoneNumber: userCredentialModel.phoneNumber,
      photoUrl: userCredentialModel.photoURL,
      refreshToken: userCredentialModel.refreshToken,
      username: name.toLowerCase().replaceAll(' ', '_'),
      bio: AppStrings.defaultUserBioText,
      joiningDate: DateFormat(
        AppConstants.monthYearFormatPattern,
      ).format(DateTime.now()),
      // TODO: implement this part later
      // fcmToken: FirebaseCloudMessagingManager.fcmToken,
      fcmToken: '',
    );

    Future.wait([
      _authRemoteDataSource.updateDisplayName(name: name),
      _authLocalDataSource.cacheUserUid(uid: userCredentialModel.uid),
      _authRemoteDataSource.updateUserProfile(profile: userProfileModel)
    ]);

    // FirebaseAuthManager.updateDisplayName(name)
    //     .then((value) {
    //       SharedPreferencesHelper.setData(userIdKey, credential.user!.uid)
    //           .then((value) async {
    //             UserProfile userProfile = UserProfile(
    //               user: credential.user!,
    //               displayName: name,
    //               username: name.toLowerCase().replaceAll(' ', '_'),
    //               photoUrl: null,
    //               coverPhotoUrl: null,
    //               bio: 'Tell others about you.',
    //               location: null,
    //               fcmToken: FirebaseCloudMessagingManager.fcmToken,
    //               joiningDate: DateFormat(
    //                 'MMMM yyyy',
    //               ).format(DateTime.now()),
    //             );
    //             FirestoreManager.updateUserProfile(userProfile)
    //                 .then((value) {
    //                   emit(
    //                     AuthRegisterSuccessState(
    //                       userProfile: userProfile,
    //                     ),
    //                   );
    //                 })
    //                 .catchError((error) {
    //                   emit(
    //                     AuthRegisterErrorState(
    //                       errorMessage:
    //                           'Error happened while creating user profile: ${error.toString()}',
    //                     ),
    //                   );
    //                 });
    //           })
    //           .catchError((error) {
    //             emit(
    //               AuthRegisterErrorState(
    //                 errorMessage:
    //                     'Error happened while caching user token: ${error.toString()}',
    //               ),
    //             );
    //           });
    //     })
    //     .catchError((error) {
    //       emit(
    //         AuthRegisterErrorState(
    //           errorMessage:
    //               'Error happened while updating user: ${error.toString()}',
    //         ),
    //       );
    //     });

    return userProfileModel.toEntity();
  }

  @override
  Future<UserCredentialEntity> loginUser({
    required String email,
    required String password,
  }) async {
    final userCredentialModel = await _authRemoteDataSource.loginUser(
      email: email,
      password: password,
    );
    await _authLocalDataSource.cacheUserUid(uid: userCredentialModel.uid);
    return userCredentialModel.toEntity();
  }
}
