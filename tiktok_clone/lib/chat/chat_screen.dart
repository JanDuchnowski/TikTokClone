import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {Key? key, required this.currentUser, required this.interlocutorUser})
      : super(key: key);

  final User currentUser;
  final User interlocutorUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(currentUser.name),
          Text(interlocutorUser.name),
        ],
      ),
    );
  }
}
