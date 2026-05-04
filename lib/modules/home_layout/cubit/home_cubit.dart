import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }

  // TODO: for testing purposes only, remove later
  void getUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(GotUser(FirebaseAuth.instance.currentUser!));
    } else {
      throw 'null user';
    }
  }
}
