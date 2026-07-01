import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';
import 'package:nexus/features/auth/domain/use_cases/register_use_case.dart';
import 'package:nexus/features/auth/domain/use_cases/login_use_case.dart';
import 'package:nexus/features/auth/presentation/viewmodel/auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthCubit(this._loginUseCase, this._registerUseCase)
    : super(AuthInitialState());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoginPasswordVisible = false;

  void createUser({
    required String name,
    required String email,
    required String password,
  }) {
    emit(AuthRegisterLoadingState());

    _registerUseCase(name: name, email: email, password: password)
        .then((UserProfileEntity userProfile) {
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
          emit(AuthRegisterSuccessState(userProfile: userProfile));
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
        })
        .catchError((exception) {
          // String errorMessage =
          //     'Error happened while creating user: ${exception.toString()}';
          // switch (exception.code) {
          //   case emailUsed:
          //     errorMessage = emailUsedResponse;
          //     break;
          //   case invalidEmail:
          //     errorMessage = invalidEmailResponse;
          //     break;
          //   case weakPassword:
          //     errorMessage = weakPasswordResponse;
          //     break;
          //   case networkFailure:
          //     errorMessage = networkFailureResponse;
          //     break;
          // }
          emit(AuthRegisterErrorState(errorMessage: exception.toString()));
        });
  }

  void loginUser({required String email, required String password}) {
    emit(AuthLoginLoadingState());

    _loginUseCase(email: email, password: password)
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
