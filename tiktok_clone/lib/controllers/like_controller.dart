import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class LikeController {
  final String postId;

  LikeController({required this.postId});

  Future<void> incrementLikes() async {
    //Check if the current user has already liked the video
    //if not like and add him to the list of users who liked
    //if yes return

    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final List usersWhoLikedPost = likesSnapshot['usersWhoLiked'];

    if (usersWhoLikedPost.contains(AuthController().user!.uid)) {
      return;
    }

    usersWhoLikedPost.add(AuthController().user!.uid);
    final numberOfLikes = likesSnapshot['likes'];

    await Storage().firestore.collection('posts').doc(postId).update(
        {"likes": numberOfLikes + 1, "usersWhoLiked": usersWhoLikedPost});
  }
}
