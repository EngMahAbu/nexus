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
  late UserProfile userProfile;

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }

  // TODO: for testing purposes only, remove later
  void getUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      User user = FirebaseAuth.instance.currentUser!;
      FirestoreManager.getUserProfile(user.uid)
          .then((value) {
            userProfile = UserProfile.fromMap(
              user: user,
              json: value.data()!,
            );
            emit(GotUser(userProfile));
          })
          .catchError((error) {
            throw error;
          });
    } else {
      throw 'null user';
    }
  }
}
