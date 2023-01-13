import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class LikeController {
  static final LikeController _singleton = LikeController._internal();

  factory LikeController() {
    return _singleton;
  }

  LikeController._internal();
  String? postId;

  //TODO make the function work both for liking posts and comment
  Future<void> incrementLikes() async {
    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final List usersWhoLikedPost = likesSnapshot['likes'];
    if (usersWhoLikedPost.contains(AuthController().user!.uid)) {
      usersWhoLikedPost.remove(AuthController().user!.uid);
      await Storage()
          .firestore
          .collection('posts')
          .doc(postId)
          .update({"likes": usersWhoLikedPost});
      return;
    }

    usersWhoLikedPost.add(AuthController().user!.uid);

    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": usersWhoLikedPost});
  }
}
