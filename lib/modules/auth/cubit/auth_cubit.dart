import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nexus/features/auth/api/client/firebase_auth_client.dart';
import 'package:nexus/features/auth/api/data_sources/auth_remote_data_source_impl.dart';
import 'package:nexus/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nexus/modules/auth/cubit/auth_states.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/network/remote/firebase_auth_manager.dart';
import 'package:nexus/shared/network/remote/firebase_cloud_messaging_manager.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  late final LoginUseCase _loginUseCase;

  AuthCubit() : super(AuthInitialState()) {
    // TODO: Keep it like this until implementing DI
    _loginUseCase = LoginUseCase(
      AuthRepositoryImpl(AuthRemoteDataSourceImpl(FirebaseAuthClient())),
    );
  }

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoginPasswordVisible = false;

  void createUser({
    required String name,
    required String email,
    required String password,
  }) {
    emit(AuthRegisterLoadingState());

    FirebaseAuthManager.createUser(email: email, password: password)
        .then((UserCredential credential) {
          FirebaseAuthManager.updateDisplayName(name)
              .then((value) {
                SharedPreferencesHelper.setData(userIdKey, credential.user!.uid)
                    .then((value) async {
                      UserProfile userProfile = UserProfile(
                        user: credential.user!,
                        displayName: name,
                        username: name.toLowerCase().replaceAll(' ', '_'),
                        photoUrl: null,
                        coverPhotoUrl: null,
                        bio: 'Tell others about you.',
                        location: null,
                        fcmToken: FirebaseCloudMessagingManager.fcmToken,
                        joiningDate: DateFormat(
                          'MMMM yyyy',
                        ).format(DateTime.now()),
                      );
                      FirestoreManager.updateUserProfile(userProfile)
                          .then((value) {
                            emit(
                              AuthRegisterSuccessState(
                                userProfile: userProfile,
                              ),
                            );
                          })
                          .catchError((error) {
                            emit(
                              AuthRegisterErrorState(
                                errorMessage:
                                    'Error happened while creating user profile: ${error.toString()}',
                              ),
                            );
                          });
                    })
                    .catchError((error) {
                      emit(
                        AuthRegisterErrorState(
                          errorMessage:
                              'Error happened while caching user token: ${error.toString()}',
                        ),
                      );
                    });
              })
              .catchError((error) {
                emit(
                  AuthRegisterErrorState(
                    errorMessage:
                        'Error happened while updating user: ${error.toString()}',
                  ),
                );
              });
        })
        .catchError((exception) {
          String errorMessage =
              'Error happened while creating user: ${exception.toString()}';
          switch (exception.code) {
            case emailUsed:
              errorMessage = emailUsedResponse;
              break;
            case invalidEmail:
              errorMessage = invalidEmailResponse;
              break;
            case weakPassword:
              errorMessage = weakPasswordResponse;
              break;
            case networkFailure:
              errorMessage = networkFailureResponse;
              break;
          }
          emit(AuthRegisterErrorState(errorMessage: errorMessage));
        });
  }

  void loginUser({required String email, required String password}) {
    emit(AuthLoginLoadingState());

    // TODO: send the userIdKey for now, resolve this later
    _loginUseCase(email: email, password: password, userIdKey: userIdKey)
        .then((value) {
          emit(AuthLoginSuccessState(credential: value));
        })
        .catchError((error) {
          emit(
            AuthLoginErrorState(
              errorMessage:
                  'Error happened while caching user token: ${error.toString()}',
            ),
          );
        });
    // });
    // .catchError((exception) {
    //   String errorMessage =
    //       'Error happened while creating user: ${exception.toString()}';
    //   switch (exception.code) {
    //     case invalidEmail:
    //       errorMessage = invalidEmailResponse;
    //       break;
    //     case userDisabled:
    //       errorMessage = userDisabledResponse;
    //       break;
    //     case networkFailure:
    //       errorMessage = networkFailureResponse;
    //       break;
    //     case invalidCredential:
    //       errorMessage = invalidCredentialResponse;
    //       break;
    //   }
    //   emit(AuthLoginErrorState(errorMessage: errorMessage));
    // });
  }

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible = !isLoginPasswordVisible;
    emit(AuthLoginPasswordVisibilityChangedState());
  }
}
