import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class PostService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostStream() {
    return Storage().firestore.collection('posts').snapshots();
  }

  void likePost(String postId) async {
    final currentUser = await AuthController().getCurrentUser();
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    //addToLiked!(postId);
    final List usersWhoLikedPost = likesSnapshot['likes'];
    if (usersWhoLikedPost.contains(currentUser!.uid)) {
      print("Removing a like");
      usersWhoLikedPost.remove(currentUser.uid);

      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .update({"likes": usersWhoLikedPost});
      return;
    }

    usersWhoLikedPost.add(currentUser.uid);
    print("Adding a like");
    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": usersWhoLikedPost});
  }
}
