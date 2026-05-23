import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  UserProfile? _userProfile;

  UserProfile get userProfile {
    if (_userProfile == null) {
      return getUserProfile();
    }
    return _userProfile!;
  }

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }

  UserProfile getUserProfile() {
    emit(ProfileGetLoadingState());

    if (_userProfile != null) {
      emit(ProfileGetSuccessState(userProfile));
      return userProfile;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'null user';
    }

    FirestoreManager.getUserProfile(user.uid)
        .then((value) {
          _userProfile = UserProfile.fromMap(user: user, json: value.data()!);
          emit(ProfileGetSuccessState(userProfile));
        })
        .catchError((error) {
          emit(
            ProfileGetErrorState(
              errorMessage: 'Error happened while getting user profile: $error',
            ),
          );
        });
    return userProfile;
  }

  void updateUserProfile(UserProfile newProfile) {
    emit(ProfileUpdateLoadingState());

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'null user';
    }

    FirestoreManager.updateUserProfile(newProfile)
        .then((value) {
          _userProfile = newProfile;
          emit(ProfileUpdateSuccessState(_userProfile!));
        })
        .catchError((error) {
          emit(
            ProfileUpdateErrorState(
              errorMessage:
                  'Error happened while updating user profile: $error',
            ),
          );
        });
  }
}
