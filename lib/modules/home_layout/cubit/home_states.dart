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

class CoverPhotoPickLoadingState extends HomeStates {}

class CoverPhotoPickSuccessState extends HomeStates {}

class CoverPhotoPickErrorState extends HomeStates {
  final String errorMessage;

  CoverPhotoPickErrorState({required this.errorMessage});
}

class AvatarPhotoPickLoadingState extends HomeStates {}

class AvatarPhotoPickSuccessState extends HomeStates {}

class AvatarPhotoPickErrorState extends HomeStates {
  final String errorMessage;

  AvatarPhotoPickErrorState({required this.errorMessage});
}

class PhotoUploadLoadingState extends HomeStates {}

class PhotoUploadSuccessState extends HomeStates {}

class PhotoUploadErrorState extends HomeStates {
  final String errorMessage;

  PhotoUploadErrorState({required this.errorMessage});
}

class PostCreationLoadingState extends HomeStates {}

class PostCreationSuccessState extends HomeStates {}

class PostCreationErrorState extends HomeStates {
  final String errorMessage;

  PostCreationErrorState({required this.errorMessage});
}

class PostsGetLoadingState extends HomeStates {}

class PostsGetSuccessState extends HomeStates {}

class PostsGetErrorState extends HomeStates {
  final String errorMessage;

  PostsGetErrorState({required this.errorMessage});
}
