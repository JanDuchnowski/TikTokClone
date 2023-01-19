import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/user/user.dart';

class CommentController {
  final String postId;

  CommentController({required this.postId});

  Future<void> postComment(String newCommentText) async {
    final User? currentUser = await AuthController().getCurrentUser();
    DocumentSnapshot userDoc = await Storage()
        .firestore
        .collection('users')
        .doc(currentUser!.uid)
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
      datePublished: Timestamp.now().toDate(),
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
}
