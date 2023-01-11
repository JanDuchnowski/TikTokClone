import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';

import 'package:tiktok_clone/controllers/video_controller.dart';

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
    VideoController().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final data = VideoController().videoList[index];
          return Stack(children: [
            VideoPost(
              dataSource: data.videoUrl,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                data.username,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.caption,
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
                                    data.songName,
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
                    ],
                  ),
                ),
              ],
            )
          ]);
        },
      ),
    );
  }
}
