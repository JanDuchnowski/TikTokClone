import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentController {
  final String postId;

  CommentController({required this.postId});

  Future<void> postComment(String newCommentText) async {
    DocumentSnapshot userDoc = await Storage()
        .firestore
        .collection('users')
        .doc(AuthController().user!.uid)
        .get();

    var allDocs = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    int len = allDocs.docs.length;

    final Comment newComment = Comment(
      username: (userDoc.data()! as dynamic)['name'],
      comment: newCommentText,
      datePublished: Timestamp.now(),
      likes: [],
      profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
      uid: (userDoc.data()! as dynamic)['uid'],
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

    final commentSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final commentCount = commentSnapshot['commentCount'];
    await Storage().firestore.collection('posts').doc(postId).update(
      {"commentCount": commentCount + 1},
    );
  }

  Future<void> incrementCommentLikes(String commentId) async {
    final commentSnapshot = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .get();

    final List usersWhoLikedComment = commentSnapshot['likes'];

    if (usersWhoLikedComment.contains(AuthController().user!.uid)) {
      usersWhoLikedComment.remove(AuthController().user!.uid);
      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({"likes": usersWhoLikedComment});
      return;
    }

    usersWhoLikedComment.add(AuthController().user!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .update({"likes": usersWhoLikedComment});

    // final commentSnapshotAfterwards = await Storage()
    //     .firestore
    //     .collection('posts')
    //     .doc(postId)
    //     .collection('comments')
    //     .doc(commentId)
    //     .get();
  }
}
