import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/video/video.dart';

class VideoController {
  static final VideoController _singleton = VideoController._internal();

  factory VideoController() {
    return _singleton;
  }
  String? postId;
  late List<Video> videoList;
  VideoController._internal();
  Future<void> incrementLikes() async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final List usersWhoLikedPost = likesSnapshot['likes'];
    if (usersWhoLikedPost.contains(AuthController().user!.uid)) {
      usersWhoLikedPost.remove(AuthController().user!.uid);
      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .update({"likes": usersWhoLikedPost});
      return;
    }

    usersWhoLikedPost.add(AuthController().user!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": usersWhoLikedPost});
  }
}
