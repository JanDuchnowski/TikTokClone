import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId) {
    return Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy("datePublished")
        .snapshots();
  }

  void postComment(String commentText, String postId) async {
    final User? currentUser = await AuthController().getCurrentUser();

    var allDocs = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();

    final int len = allDocs.docs.length;

    final Comment newComment = Comment(
      username: currentUser!.name,
      comment: commentText,
      datePublished: Timestamp.now().toDate(),
      likes: [],
      profilePhoto: currentUser.profilePhoto,
      uid: currentUser.uid,
      id: 'Comment $len',
    );

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc('Comment $len')
        .set(
          newComment.toJson(),
        );

    await Storage().firestore.collection('posts').doc(postId).update(
      {"commentCount": FieldValue.increment(1)},
    );
  }

  void likeComment(String commentId, String postId) async {
    final User? currentUser = await AuthController().getCurrentUser();
    final commentSnapshot = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .get();

    final List usersWhoLikedComment = commentSnapshot['likes'];

    if (usersWhoLikedComment.contains(currentUser!.uid)) {
      usersWhoLikedComment.remove(currentUser.uid);
      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({"likes": usersWhoLikedComment});
      return;
    }

    usersWhoLikedComment.add(currentUser.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .update({"likes": usersWhoLikedComment});
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
}
