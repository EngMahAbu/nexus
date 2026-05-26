import 'package:nexus/models/auth/user_profile.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavBarClickedState extends HomeStates {}

class ProfileGetLoadingState extends HomeStates {}

class ProfileGetSuccessState extends HomeStates {
  final UserProfile profile;

  ProfileGetSuccessState(this.profile);
}

class ProfileGetErrorState extends HomeStates {
  final String errorMessage;

  ProfileGetErrorState({required this.errorMessage});
}

class ProfileUpdateLoadingState extends HomeStates {}

class ProfileUpdateSuccessState extends HomeStates {
  final UserProfile profile;

  ProfileUpdateSuccessState(this.profile);
}

class ProfileUpdateErrorState extends HomeStates {
  final String errorMessage;

  ProfileUpdateErrorState({required this.errorMessage});
}

class PhotoPickLoadingState extends HomeStates {}

class PhotoPickSuccessState extends HomeStates {}

class PhotoPickErrorState extends HomeStates {
  final String errorMessage;

  PhotoPickErrorState({required this.errorMessage});
}
