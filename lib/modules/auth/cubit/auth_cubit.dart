import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/modules/auth/cubit/auth_states.dart';
import 'package:nexus/shared/network/remote/firebase_auth_manager.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  void createUser({required String email, required String password}) {
    emit(AuthRegisterLoadingState());

    FirebaseAuthManager.createUser(email: email, password: password)
        .then((UserCredential credential) {
          emit(AuthRegisterSuccessState(credential: credential));
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
}
