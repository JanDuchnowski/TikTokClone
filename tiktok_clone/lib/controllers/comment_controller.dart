import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentController {
  final String postId;

  CommentController({required this.postId});

  Future<void> postComment(String newCommentText) async {
    // final commentSnapshot =
    //     await Storage().firestore.collection('posts').doc(postId).get();

    // final List comments = commentSnapshot['comments'];
    // comments.add(newCommentText);

    // await Storage()
    //     .firestore
    //     .collection('posts')
    //     .doc(postId)
    //     .update({"comments": comments});

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
  }
}
