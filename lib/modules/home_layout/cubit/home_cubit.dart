import 'package:flutter/material.dart';
import 'package:nexus/modules/chat_screen/chat_screen.dart';
import 'package:nexus/modules/home_layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/modules/home_screen/home_screen.dart';
import 'package:nexus/modules/new_post_screen/new_post_screen.dart';
import 'package:nexus/modules/profile_screen/profile_screen.dart';
import 'package:nexus/modules/users_screen/users_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomNavCurrentIndex = 0;
  List<Widget> bottomNavScreens = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];

  void changeBottomNavBar(int newIndex) {
    bottomNavCurrentIndex = newIndex;
    emit(HomeBottomNavBarClickedState());
  }
}
