import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/like_controller.dart';

import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/video.dart';

import 'package:tiktok_clone/views/widgets/video_post.dart';

class TikTokFeed extends StatefulWidget {
  TikTokFeed({Key? key}) : super(key: key);

  @override
  State<TikTokFeed> createState() => _TikTokFeedState();
}

class _TikTokFeedState extends State<TikTokFeed> {
  List<String>? postsList;
  @override
  void initState() {
    super.initState();
    //  VideoController().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Storage().firestore.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
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
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    currentVideo.username,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
                                    final LikeController likeController =
                                        LikeController(postId: currentVideo.id);
                                    likeController.incrementLikes();
                                  },
                                  icon: const Icon(Icons.favorite),
                                ),
                                Text(currentVideo.likes.toString()),
                                const SizedBox(
                                  height: 10,
                                ),
                                IconButton(
                                  onPressed: () {},
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
    );
  }
}
