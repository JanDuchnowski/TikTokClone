import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/user/user.dart';

class PostService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream() {
    return Storage().firestore.collection('posts').snapshots();
  }

  Future<String?> likePost(String postId) async {
    final currentUser = await AuthController().getCurrentUser();
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    final List usersWhoLikedPost = likesSnapshot['likes'];
    if (usersWhoLikedPost.contains(currentUser!.uid)) {
      print("are we even here");
      removeLike(postId);
    } else {
      usersWhoLikedPost.add(currentUser.uid);

      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .update({"likes": usersWhoLikedPost});
    }

    return postId;
  }

  Future<String?> removeLike(String postId) async {
    final currentUser = await AuthController().getCurrentUser();
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    final List usersWhoLikedPost = likesSnapshot['likes'];
    usersWhoLikedPost.remove(currentUser!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": usersWhoLikedPost});

    return postId;
  }

  Future<List<dynamic>> getCurrentlyLikedPosts() async {
    final currentUser = await AuthController().getCurrentUser();
    return currentUser!.currentlyLikedPosts;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendPostStream(
      List<String> friendsList) {
    if (friendsList.isNotEmpty) {
      return Storage()
          .firestore
          .collection('posts')
          .where("uid", whereIn: friendsList)
          .snapshots();
    }
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return Storage()
        .firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}