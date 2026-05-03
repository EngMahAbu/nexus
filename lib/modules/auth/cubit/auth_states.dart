abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthLoginLoadingState extends AuthStates {}
class AuthLoginSuccessState extends AuthStates {}
class AuthLoginErrorState extends AuthStates {}