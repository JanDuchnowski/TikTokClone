import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/service/post_service.dart';

abstract class PostRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream();
  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsPosts(
      List<String> friendsList);
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(String uid);
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
  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsPosts(
      List<String> friendsList) {
    return _postService.getFriendPostStream(friendsList);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return _postService.getProfileInfoStream(uid);
  }
}
