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
    // videoController.fetchPosts();
    super.initState();
    //print(AuthController().videoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 5,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          //  final data = AuthController().videoList![index];
          //  print(data.toString());
          return Stack(
            children: const [
              VideoPost(
                dataSource:
                    'https://firebasestorage.googleapis.com/v0/b/tiktokclone-c2cf7.appspot.com/o/posts%2Fdata%2Fuser%2F0%2Fcom.example.tiktok_clone%2Fcache%2Fimage_picker3014159889285237038.mpeg?alt=media&token=b15a7140-1cc2-41d4-9a23-5a74655f1d05',
              ),
            ],
          );
        },
      ),
    );
  }
}
