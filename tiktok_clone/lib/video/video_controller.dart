import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/video/video.dart';

class VideoController {
  static final VideoController _singleton = VideoController._internal();

  factory VideoController() {
    return _singleton;
  }
  String? postId;
  Function? addToLiked;
  VideoController._internal();
  Future<void> incrementLikes(List<String> postsLikedByCurrentUser) async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    addToLiked!(postId);
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

  Future<List<String>> getUsers() async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final List<String> usersWhoLikedPost = likesSnapshot['likes'];
    return usersWhoLikedPost;
  }
}
