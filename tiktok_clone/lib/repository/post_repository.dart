import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/repository/post_service.dart';

abstract class PostRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream();
  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId);
  Future<String?> likePost(String postId);
  Future<String?> removeLike(String postId);
  Future<List<dynamic>> getCurrentlyLikedPosts();
  void postComment(String commentText, String postId);
  void likeComment(String commentId, String postId);
}

class PostRepository implements PostRepositoryInterface {
  final PostService _postService = PostService();
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream() {
    return _postService.getPostStream();
  }

  @override
  Future<String?> likePost(String postId) {
    return _postService.likePost(postId);
  }

  @override
  Future<List<dynamic>> getCurrentlyLikedPosts() {
    return _postService.getCurrentlyLikedPosts();
  }

  @override
  Future<String?> removeLike(String postId) {
    return _postService.removeLike(postId);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getCommentStream(String postId) {
    return _postService.getCommentStream(postId);
  }

  @override
  void postComment(String commentText, String postId) {
    _postService.postComment(commentText, postId);
  }

  @override
  void likeComment(String commentId, String postId) {
    _postService.likeComment(commentId, postId);
  }
}
