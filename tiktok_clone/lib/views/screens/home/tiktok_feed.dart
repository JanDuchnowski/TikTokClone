import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/views/widgets/video_post.dart';
import 'package:video_player/video_player.dart';

class TikTokFeed extends StatelessWidget {
  const TikTokFeed({Key? key}) : super(key: key);

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

          return ListView(
            children: snapshot.data!.docs.map((document) {
              print(document["video"]);
              final VideoPlayerController controller =
                  VideoPlayerController.network(document['video']);
              controller.initialize();
              controller.play();
              return VideoPost(dataSource: document['video']);
            }).toList(),
          );
        },
      ),
    );
  }
}
