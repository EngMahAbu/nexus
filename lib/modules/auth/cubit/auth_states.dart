import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus/models/auth/user_profile.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {
  final UserProfile userProfile;

  AuthRegisterSuccessState({required this.userProfile});
}

class AuthRegisterErrorState extends AuthStates {
  final String errorMessage;

  AuthRegisterErrorState({required this.errorMessage});
}

class AuthLoginPasswordVisibilityChangedState extends AuthStates {}

class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  final UserCredential credential;

  AuthLoginSuccessState({required this.credential});
}

class AuthLoginErrorState extends AuthStates {
  final String errorMessage;

  AuthLoginErrorState({required this.errorMessage});
}
