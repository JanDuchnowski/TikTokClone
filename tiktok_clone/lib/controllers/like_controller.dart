import 'package:tiktok_clone/firebase/storage.dart';

class LikeController {
  final String postId;

  LikeController({required this.postId});

  Future<void> incrementLikes() async {
    print("was called");

    final likesSnapshot =
        await Storage().firestore.collection('posts').doc(postId).get();

    final numberOfLikes = likesSnapshot['likes'];
    print(numberOfLikes);
    print("I am here");
    await Storage()
        .firestore
        .collection('posts')
        .doc(postId)
        .update({"likes": numberOfLikes + 1});
  }
}
