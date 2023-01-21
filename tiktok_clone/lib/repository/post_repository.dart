import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/service/post_service.dart';

abstract class PostRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream();
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>? getFriendsPosts();
  Future<String?> likePost(String postId);
  Future<String?> removeLike(String postId);
  Future<List<dynamic>> getCurrentlyLikedPosts();
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
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getFriendsPosts() async {
    return await _postService.getFriendPostStream();
  }
}
