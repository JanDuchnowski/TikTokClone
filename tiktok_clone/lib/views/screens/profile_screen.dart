import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/profile/profile_bloc.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/views/screens/followers_screen.dart';
import 'package:tiktok_clone/widgets/video/video_post.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) {
              if (current.userId == userId) {
                return true;
              } else {
                return false;
              }
            }, builder: (context, state) {
              if (state.profileInfoQuery != null) {
                return ListView(
                    shrinkWrap: true,
                    children: state.profileInfoQuery!.docs.map(
                      (document) {
                        final User currentUser = User.fromSnap(document);

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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // context.read<ProfileBloc>().add(
                                    //     FetchFollowersEvent(
                                    //         profileUser: currentUser));
                                    context.read<ProfileBloc>().add(
                                        FetchFollowingEvent(
                                            profileUser: currentUser));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowersScreen(
                                                    user: currentUser)));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        currentUser.following.length.toString(),
                                      ),
                                      const Text("Following"),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                InkWell(
                                  onTap: (() {
                                    context.read<ProfileBloc>().add(
                                        FetchFollowersEvent(
                                            profileUser: currentUser));
                                    // context.read<ProfileBloc>().add(
                                    //     FetchFollowingEvent(
                                    //         profileUser: currentUser));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowersScreen(
                                                    user: currentUser)));
                                  }),
                                  child: Column(
                                    children: [
                                      Text(
                                        currentUser.followers.length.toString(),
                                      ),
                                      const Text("Followers"),
                                    ],
                                  ),
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
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Storage().firebaseAuth.currentUser!.uid != userId
                  ? Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(FollowUserEvent(otherUserId: userId));
                        },
                        child: const Text("Follow"),
                      ),
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              const SizedBox(
                width: 32,
              ),
              Storage().firebaseAuth.currentUser!.uid == userId
                  ? Container(
                      margin: Storage().firebaseAuth.currentUser!.uid != userId
                          ? const EdgeInsets.only(right: 0.0)
                          : const EdgeInsets.only(right: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(
                              AuthenticationSignedOutEvent(context: context));

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/signup', (route) => false);
                        },
                        child: const Text("Sign Out"),
                      ),
                    )
                  : Container(),
            ],
          ),
          Flexible(
            child: BlocBuilder<ProfileBloc, ProfileState>(
                buildWhen: (previous, current) {
              if (current.profilePosts != null) {
                return true;
              }
              return false;
            }, builder: ((context, state) {
              if (state.profileStatus == ProfileStatus.fetched) {
                return SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    children: state.profilePosts!.docs.map((document) {
                      Video video = Video.fromSnap(document);
                      return VideoPost(
                        dataSource: video.videoUrl,
                      );
                    }).toList(),
                  ),
                );
              }
              return const CircularProgressIndicator();
            })),
          )
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentlySelected: 4,
      ),
    );
  }
}
