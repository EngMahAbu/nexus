import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class HomeBottomNavBarClickedState extends HomeStates {}
// TODO: for testing only, remove later
class GotUser extends HomeStates {
  final User user;

  GotUser(this.user);
}
