import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/profile/profile_bloc.dart';
import 'package:tiktok_clone/models/user/user.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key, required this.user}) : super(key: key);

  final User? user;
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  int chosenTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.user!.name),
        centerTitle: true,
      ),
      body: Container(
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: (() => setState(() {
                        chosenTab = 0;
                      })),
                  child: Text("Following"),
                ),
                TextButton(
                  onPressed: (() => setState(() {
                        chosenTab = 1;
                      })),
                  child: Text("Followers"),
                ),
              ],
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.followingList != null &&
                    state.followersList != null) {
                  print("got here");
                  return ListView(
                      shrinkWrap: true,
                      children: chosenTab == 0
                          ? _buildListView(context, state.followingList!)
                          : _buildListView(context, state.followersList!));
                }
                return Container(child: Text("Lists are null"));
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListView(BuildContext context, List<User> userList) {
    print("Got here");
    return userList.map((user) {
      return ListTile(
        leading: Image.network(
          user.profilePhoto,
          errorBuilder: ((context, error, stackTrace) =>
              const Text("Error fetching user profile photo")),
        ),
        title: Text(user.name),
        trailing: ElevatedButton(
          onPressed: () {
            context
                .read<ProfileBloc>()
                .add(FollowUserEvent(otherUserId: user.uid));
          },
          child: const Text("Follow"),
        ),
      );
    }).toList();
  }
}
