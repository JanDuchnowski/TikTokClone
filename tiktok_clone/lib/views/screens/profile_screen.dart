import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/bloc/tiktok_bloc.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/widgets/video/video_post.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: BlocBuilder<TiktokBloc, TiktokState>(
                  builder: (context, state) {
                if (state.postInfoQuery != null) {
                  return ListView(
                      shrinkWrap: true,
                      children: state.postInfoQuery!.docs.map(
                        (document) {
                          final User currentUser = User.fromSnap(document);
                          print("Username = ${document.data()}");
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(currentUser.profilePhoto),
                                radius: 60,
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                currentUser.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        currentUser.following.length.toString(),
                                      ),
                                      const Text("Following"),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        currentUser.followers.length.toString(),
                                      ),
                                      const Text("Followers"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ).toList());
                }
                return Text("Stream was null");
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Storage().firebaseAuth.currentUser!.uid != userId
                    ? ElevatedButton(
                        onPressed: () {
                          // _profileController.followUser(userId);
                        },
                        child: Text("Follow"),
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                SizedBox(
                  width: 32,
                ),
                Container(
                  margin: Storage().firebaseAuth.currentUser!.uid != userId
                      ? const EdgeInsets.only(right: 0.0)
                      : const EdgeInsets.only(right: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      AuthController().signOut();

                      Navigator.of(context).popUntil(
                          ModalRoute.withName(Routes.signupScreenRoute));
                    },
                    child: Text("Sign Out"),
                  ),
                ),
              ],
            ),
            Flexible(
              child: StreamBuilder(
                stream: Storage()
                    .firestore
                    .collection("users")
                    .doc(userId)
                    .collection("posts")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No data");
                  }

                  return SingleChildScrollView(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: snapshot.data!.docs.map((document) {
                        Video video = Video.fromSnap(document);
                        return VideoPost(
                          dataSource: video.videoUrl,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentlySelected: 4,
      ),
    );
  }
}
