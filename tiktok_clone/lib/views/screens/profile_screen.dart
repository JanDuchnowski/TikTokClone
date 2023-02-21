import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/comment/comment_bloc.dart';
import 'package:tiktok_clone/bloc/profile/profile_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart';
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
                                    context.read<ProfileBloc>().add(
                                        FetchFollowersEvent(
                                            profileUser: currentUser));
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
                                    context.read<ProfileBloc>().add(
                                        FetchFollowingEvent(
                                            profileUser: currentUser));
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
              return const Text("Stream was null");
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
                    // Change video ratio so they all have the same sizes, because when using crossAxisCount we are forcing them to have certain width eventough the video is way smaller
                    controller: ScrollController(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,

                    children: state.profilePosts!.docs.map((document) {
                      Video video = Video.fromSnap(document);

                      return Container(
                        child: VideoPost(
                          //on clic open tiktok feed from this post

                          dataSource: video.videoUrl,
                          playVideo: false,
                        ),
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
      bottomNavigationBar: const CustomNavigationBar(
        currentlySelected: 4,
      ),
    );
  }

  Widget _buildProfileFeed(
      int initialPage, BuildContext context, ProfileState state) {
    return PageView(
      children: state.profilePosts!.docs.map((document) {
        final currentVideo = Video.fromSnap(document);

        return Stack(children: [
          VideoPost(
            dataSource: currentVideo.videoUrl,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                context.read<ProfileBloc>().add(
                                    FetchProfileEvent(uid: currentVideo.uid));
                                // context.read<ProfileBloc>().add(
                                //     FetchProfilePostsEvent(
                                //         uid: currentVideo.uid));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      userId: currentVideo.uid,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                currentVideo.username,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              currentVideo.caption,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.music_note,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Text(
                                  currentVideo.songName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // print(
                              //     "state.likedPosts = ${state.likedPosts!.contains(currentVideo.id)}");

                              context
                                  .read<TiktokBloc>()
                                  .add(LikePostEvent(postId: currentVideo.id));
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          Text(currentVideo.likes.length.toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CommentBloc>().add(
                                  FetchCommentsEvent(postId: currentVideo.id));
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CommentScreen(
                                    videoId: currentVideo.id,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.comment),
                          ),
                          Text(currentVideo.commentCount.toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.reply),
                          ),
                          Text(currentVideo.shareCount.toString()),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ]);
      }).toList(),
    );
  }
}
