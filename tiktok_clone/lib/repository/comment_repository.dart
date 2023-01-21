import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/service/comment_service.dart';

abstract class CommentRepositoryInterface {
  void postComment(String commentText, String postId);
  void likeComment(String commentId, String postId);
  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId);
}

class CommentRepository extends CommentRepositoryInterface {
  final CommentService _commentService = CommentService();
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId) {
    return _commentService.getCommentStream(postId);
  }

  @override
  void likeComment(String commentId, String postId) {
    return _commentService.likeComment(commentId, postId);
  }

  @override
  void postComment(String commentText, String postId) {
    return _commentService.postComment(commentText, postId);
  }
}
