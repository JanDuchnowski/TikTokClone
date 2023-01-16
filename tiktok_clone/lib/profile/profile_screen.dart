import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Storage()
            .firestore
            .collection('users')
            .where('uid', isEqualTo: userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }

          return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map(
                (document) {
                  final User currentUser = User.fromSnap(document);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.profilePhoto),
                        radius: 60,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        currentUser.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                },
              ).toList());
        },
      ),
    );
  }
}
