import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';

class PostService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPostStream() {
    return Storage().firestore.collection('posts').snapshots();
  }

  Future<String?> likePost(String postId) async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    final List usersWhoLikedPost = likesSnapshot['likes'];
    if (usersWhoLikedPost.contains(Storage().firebaseAuth.currentUser!.uid)) {
      print("are we even here");
      removeLike(postId);
    } else {
      usersWhoLikedPost.add(Storage().firebaseAuth.currentUser!.uid);

      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .update({"likes": usersWhoLikedPost});
    }

    return postId;
  }

  Future<String?> removeLike(String postId) async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();
    final List usersWhoLikedPost = likesSnapshot['likes'];
    usersWhoLikedPost.remove(Storage().firebaseAuth.currentUser!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": usersWhoLikedPost});

    return postId;
  }

  Future<List<dynamic>> getCurrentlyLikedPosts(User currentUser) async {
    return currentUser.currentlyLikedPosts;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendPostStream(
      List<String> currentFriendsList) {
    if (currentFriendsList.isNotEmpty) {
      return Storage()
          .firestore
          .collection('posts')
          .where("uid", whereIn: currentFriendsList)
          .snapshots();
    }
    return null;
  }
}
