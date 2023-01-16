import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/chat/chat_screen.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/profile/profile_screen.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    super.initState();
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
                  leading: CircleAvatar(
                      foregroundImage:
                          NetworkImage(interlocutorUser.profilePhoto)),
                  title: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            userId: interlocutorUser.uid,
                          ),
                        ),
                      );
                    },
                    child: Text(interlocutorUser.name),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text("Follow"),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
