import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/user/user.dart';

class CommentService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId) {
    return Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy("datePublished")
        .snapshots();
  }

  void postComment(User currentUser, String commentText, String postId) async {
    var allDocs = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();

    final int len = allDocs.docs.length;

    final Comment newComment = Comment(
      username: currentUser.name,
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
    final commentSnapshot = await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .get();

    final List usersWhoLikedComment = commentSnapshot['likes'];

    if (usersWhoLikedComment
        .contains(Storage().firebaseAuth.currentUser!.uid)) {
      usersWhoLikedComment.remove(Storage().firebaseAuth.currentUser!.uid);
      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({"likes": usersWhoLikedComment});
      return;
    }

    usersWhoLikedComment.add(Storage().firebaseAuth.currentUser!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .update({"likes": usersWhoLikedComment});
  }
}
