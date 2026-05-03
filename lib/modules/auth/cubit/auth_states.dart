import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {
  final UserCredential credential;

  AuthRegisterSuccessState({required this.credential});
}

class AuthRegisterErrorState extends AuthStates {
  final String errorMessage;

  AuthRegisterErrorState({required this.errorMessage});
}
