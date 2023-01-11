import 'package:tiktok_clone/firebase/storage.dart';

class CommentController {
  final String postId;

  CommentController({required this.postId});
  Future<void> postComment(String newComment) async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final List comments = likesSnapshot['comments'];
    comments.add(newComment);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"comments": comments});
  }
}
