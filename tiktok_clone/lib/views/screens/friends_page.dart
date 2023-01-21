import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/comment/comment_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/models/video/video.dart';

import 'package:tiktok_clone/controllers/video_controller.dart';

import 'package:tiktok_clone/widgets/video/video_post.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';
import 'package:tiktok_clone/widgets/video/video_post.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({Key? key}) : super(key: key);

  BottomDrawerController bottomDrawerController = BottomDrawerController();
  final List<String> _postsLikedByCurrentUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TiktokBloc, TiktokState>(
        builder: (context, state) {
          if (state.status == AppStatus.postsFetched) {
            return PageView(
              scrollDirection: Axis.vertical,
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              children: state.postsQuery!.docs.map((document) {
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
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
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
                                      print(
                                          "state.likedPosts = ${state.likedPosts!.contains(currentVideo.id)}");

                                      context.read<TiktokBloc>().add(
                                          LikePostEvent(
                                              postId: currentVideo.id));
                                    },
                                    icon: Icon(
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
                                          FetchCommentsEvent(
                                              postId: currentVideo.id));
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
          return const Center(child: Text("No content from your friends"));
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentlySelected: 1,
      ),
    );
  }

  void _addToLikedPosts(String postId) {
    if (_postsLikedByCurrentUser.contains(postId)) {
      _postsLikedByCurrentUser.remove(postId);
    } else {
      _postsLikedByCurrentUser.add(postId);
    }
  }
}
