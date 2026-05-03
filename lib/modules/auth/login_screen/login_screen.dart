import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 200,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        mainAxisAlignment: .center,
        children: [const Text('This is the Login Screen')],
      ),
    );
  }
}
