import 'package:nexus/features/auth/domain/entities/user_credential_entity.dart';
import 'package:nexus/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {
  final UserProfileEntity userProfile;

  AuthRegisterSuccessState({required this.userProfile});
}

class AuthRegisterErrorState extends AuthStates {
  final String errorMessage;

  AuthRegisterErrorState({required this.errorMessage});
}

class AuthLoginPasswordVisibilityChangedState extends AuthStates {}

class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  final UserCredentialEntity credential;

  AuthLoginSuccessState({required this.credential});
}

class AuthLoginErrorState extends AuthStates {
  final String errorMessage;

  AuthLoginErrorState({required this.errorMessage});
}
