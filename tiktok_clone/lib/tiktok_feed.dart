import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/comment/presentation/comment_screen.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/profile/presentation/profile_screen.dart';
import 'package:tiktok_clone/models/video/video.dart';

import 'package:tiktok_clone/video/video_controller.dart';
import 'package:tiktok_clone/video/widgets/video_post.dart';

import 'package:tiktok_clone/video/widgets/video_post.dart';
import 'package:tiktok_clone/widgets/custom_navigation_bar.dart';

class TikTokFeed extends StatelessWidget {
  TikTokFeed({Key? key}) : super(key: key);

  BottomDrawerController bottomDrawerController = BottomDrawerController();
  List<String>? postsList;
  final List<String> postsLikedByCurrentUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Storage().firestore.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return PageView(
            scrollDirection: Axis.vertical,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 1,
            ),
            children: snapshot.data!.docs.map((document) {
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
                                    VideoController().postId = currentVideo.id;
                                    VideoController().addToLiked =
                                        addToLikedPosts;
                                    VideoController().incrementLikes(
                                        postsLikedByCurrentUser);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: postsLikedByCurrentUser
                                            .contains(document.id)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                                Text(currentVideo.likes.length.toString()),
                                const SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                  onPressed: () {
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
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentlySelected: 0,
      ),
    );
  }

  void addToLikedPosts(String postId) {
    if (postsLikedByCurrentUser.contains(postId)) {
      postsLikedByCurrentUser.remove(postId);
    } else {
      postsLikedByCurrentUser.add(postId);
    }
  }
}
