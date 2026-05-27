import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/auth/cubit/auth_states.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/network/remote/firebase_auth_manager.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

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
                    .then((value) {
                      UserProfile userProfile = UserProfile(
                        user: credential.user!,
                        displayName: name,
                        username: name.toLowerCase().replaceAll(' ', '_'),
                        photoUrl: null,
                        coverPhotoUrl: null,
                        bio: 'Tell others about you.',
                        location: null,
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

    FirebaseAuthManager.loginUser(email: email, password: password)
        .then((UserCredential credential) {
          SharedPreferencesHelper.setData(userIdKey, credential.user!.uid)
              .then((value) {
                emit(AuthLoginSuccessState(credential: credential));
              })
              .catchError((error) {
                emit(
                  AuthLoginErrorState(
                    errorMessage:
                        'Error happened while caching user token: ${error.toString()}',
                  ),
                );
              });
        })
        .catchError((exception) {
          String errorMessage =
              'Error happened while creating user: ${exception.toString()}';
          switch (exception.code) {
            case invalidEmail:
              errorMessage = invalidEmailResponse;
              break;
            case userDisabled:
              errorMessage = userDisabledResponse;
              break;
            case networkFailure:
              errorMessage = networkFailureResponse;
              break;
            case invalidCredential:
              errorMessage = invalidCredentialResponse;
              break;
          }
          emit(AuthLoginErrorState(errorMessage: errorMessage));
        });
  }

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible = !isLoginPasswordVisible;
    emit(AuthLoginPasswordVisibilityChangedState());
  }
}
