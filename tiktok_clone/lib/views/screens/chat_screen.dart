import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';

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
      bottomNavigationBar: const CustomNavigationBar(
        currentlySelected: 3,
      ),
    );
  }
}
