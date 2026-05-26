import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/models/auth/user_profile.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/shared/network/remote/firestore_manager.dart';
import 'package:nexus/shared/network/remote/supabase_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState()) {
    if (state is HomeInitialState) {
      getUserProfile();
    }
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  UserProfile? userProfile;

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }

  UserProfile? getUserProfile() {
    emit(ProfileGetLoadingState());

    if (userProfile != null) {
      emit(ProfileGetSuccessState(userProfile!));
      return userProfile!;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'Error happened while getting firebase user';
    }

    FirestoreManager.getUserProfile(user.uid)
        .then((value) {
          userProfile = UserProfile.fromMap(user: user, json: value.data()!);
          emit(ProfileGetSuccessState(userProfile!));
          return userProfile!;
        })
        .catchError((error) {
          String errorMsg = 'Error happened while getting user profile: $error';
          emit(ProfileGetErrorState(errorMessage: errorMsg));
          throw errorMsg;
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
          userProfile = newProfile;
          emit(ProfileUpdateSuccessState(userProfile!));
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

  void pickUserAvatarPhoto() async {
    emit(PhotoPickLoadingState());
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      emit(PhotoPickSuccessState());
      File file = File(result.files.single.path!);
      SupabaseManager.uploadFile(file, usersAvatarsDirectory)
          .then((value) {
            String publicUrl = SupabaseManager.getPublicUrl(
              file,
              usersAvatarsDirectory,
            );
            updateUserProfile(userProfile!.update(photoUrl: publicUrl));
          })
          .catchError((error) {
            emit(
              PhotoPickErrorState(
                errorMessage:
                    'Error happened while uploading avatar photo: $error',
              ),
            );
          });
    } else {
      emit(PhotoPickErrorState(errorMessage: 'user canceled the picker'));
    }
  }

  void pickUserCoverPhoto() async {
    emit(PhotoPickLoadingState());
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      emit(PhotoPickSuccessState());
      File file = File(result.files.single.path!);
      SupabaseManager.uploadFile(file, usersCoversDirectory)
          .then((value) {
            String publicUrl = SupabaseManager.getPublicUrl(
              file,
              usersCoversDirectory,
            );
            updateUserProfile(userProfile!.update(coverPhotoUrl: publicUrl));
          })
          .catchError((error) {
            emit(
              PhotoPickErrorState(
                errorMessage:
                    'Error happened while uploading cover photo: $error',
              ),
            );
          });
    } else {
      emit(PhotoPickErrorState(errorMessage: 'user canceled the picker'));
    }
  }
}
