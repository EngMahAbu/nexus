import 'package:flutter/material.dart';
import 'package:nexus/models/auth/user_profile.dart';

class ChatScreen extends StatelessWidget {
  final UserProfile otherUser;

  const ChatScreen({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Text('This is the Chats Screen'),
          Text('Other User is ${otherUser.displayName}'),
        ],
      ),
    );
  }
}
