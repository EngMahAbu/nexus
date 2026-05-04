import 'package:flutter/material.dart';
import 'package:nexus/modules/auth/login_screen/login_screen.dart';
import 'package:nexus/modules/home_layout/home_page.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/network/local/shared_preferences_helper.dart';
import 'package:nexus/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? userId = await SharedPreferencesHelper.getString(userIdKey);
  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: (userId == null) ? LoginScreen() : HomePage(),
    );
  }
}
