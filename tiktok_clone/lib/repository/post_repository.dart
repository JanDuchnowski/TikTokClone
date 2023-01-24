import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/service/post_service.dart';

abstract class PostRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream();
  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsPosts(
      List<String> friendsList);
  Future<String?> likePost(String postId);
  Future<String?> removeLike(String postId);
  Future<List<dynamic>> getCurrentlyLikedPosts(User currentUser);
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
  Future<List<dynamic>> getCurrentlyLikedPosts(User currentUser) {
    return _postService.getCurrentlyLikedPosts(currentUser);
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
}
