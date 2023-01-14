import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/views/screens/chat_screen.dart';

class ConversationsListScreen extends StatefulWidget {
  ConversationsListScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsListScreen> createState() =>
      _ConversationsListScreenState();
}

class _ConversationsListScreenState extends State<ConversationsListScreen> {
  User? currentUser;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final userSnapshot = await Storage()
        .firestore
        .collection('users')
        .doc(AuthController().user!.uid)
        .get();
    currentUser = User.fromSnap(userSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Storage().firestore.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) {
              return const Text("No data in snapshot");
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                final User interlocutorUser = User.fromSnap(document);
                return ListTile(
                  title: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                currentUser: currentUser!,
                                interlocutorUser: interlocutorUser)));
                      },
                      child: Text(interlocutorUser.name)),
                );
              }).toList(),
            );
          }),
    );
  }
}
