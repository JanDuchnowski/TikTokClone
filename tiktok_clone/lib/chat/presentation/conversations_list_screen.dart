import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok_bloc.dart';
import 'package:tiktok_clone/chat/presentation/chat_screen.dart';
import 'package:tiktok_clone/firebase/storage.dart';

import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/profile/bloc/profile_bloc.dart';
import 'package:tiktok_clone/profile/presentation/profile_screen.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';

class ConversationsListScreen extends StatelessWidget {
  ConversationsListScreen({Key? key}) : super(key: key);
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Storage().firestore.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("No data in snapshot");
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              final User interlocutorUser = User.fromSnap(document);
              return ListTile(
                title: TextButton(
                    onPressed: () {
                      context
                          .read<TiktokBloc>()
                          .add(FetchProfileEvent(uid: interlocutorUser.uid));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(userId: interlocutorUser.uid)
                          // ChatScreen(
                          //     currentUser: currentUser!,
                          //     interlocutorUser: interlocutorUser)
                          ));
                    },
                    child: Text(interlocutorUser.name)),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentlySelected: 3,
      ),
    );
  }
}
