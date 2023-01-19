import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/repository/post_service.dart';

abstract class PostRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostStream();
  void likePost(String postId);
}

class PostRepository implements PostRepositoryInterface {
  final PostService _postService = PostService();
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostStream() {
    return _postService.getPostStream();
  }

  @override
  void likePost(String postId) {
    _postService.likePost(postId);
  }
}
