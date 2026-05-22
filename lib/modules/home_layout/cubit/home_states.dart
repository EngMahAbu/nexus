import 'package:nexus/models/auth/user_profile.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class HomeBottomNavBarClickedState extends HomeStates {}
// TODO: for testing only, remove later
class GotUser extends HomeStates {
  final UserProfile user;

  GotUser(this.user);
}
