import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/views/widgets/video_post.dart';
import 'package:video_player/video_player.dart';

class TikTokFeed extends StatefulWidget {
  TikTokFeed({Key? key}) : super(key: key);

  @override
  State<TikTokFeed> createState() => _TikTokFeedState();
}

class _TikTokFeedState extends State<TikTokFeed> {
  final VideoController videoController = VideoController();
  List<String>? postsList;
  @override
  void initState() {
    videoController.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final data = AuthController().videoList![index];
          return Stack(
            children: [
              VideoPost(
                dataSource: data.toString(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 60,
                  child: Column(
                    children: [
                      Text(AuthController().user!.displayName!),
                      Text("test")
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
