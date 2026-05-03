import 'package:flutter/material.dart';
import 'package:nexus/modules/auth/register_screen/register_screen.dart';
import 'package:nexus/shared/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: RegisterScreen(),
    );
  }
}
