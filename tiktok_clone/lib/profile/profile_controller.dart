import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart';

class ProfileController {
  final String userId;
  User? currentUser;
  ProfileController({required this.userId});

  Future<void> followUser(String otherUserId) async {
    final otherUserDocument =
        await Storage().firestore.collection('users').doc(otherUserId).get();
    final currentUserDocument = await Storage()
        .firestore
        .collection('users')
        .doc(Storage().firebaseAuth.currentUser!.uid)
        .get();
    final currentUserFollower = User.fromSnap(currentUserDocument);
    final List followersOfTheOtherUser = otherUserDocument['followers'];
    final List followingOfTheCurrentUser = currentUserDocument['following'];
    if (followersOfTheOtherUser.contains(currentUserFollower.uid)) {
      print("unfollow");
      followersOfTheOtherUser.remove(currentUserFollower.uid);
      followingOfTheCurrentUser.remove(otherUserId);

      await Storage()
          .firestore
          .collection('users')
          .doc(Storage().firebaseAuth.currentUser!.uid)
          .update({"following": followingOfTheCurrentUser});

      await Storage()
          .firestore
          .collection('users')
          .doc(otherUserId)
          .update({"followers": followersOfTheOtherUser});
      return;
    }
    print("follow");
    followersOfTheOtherUser.add(AuthController().user!.uid);
    followingOfTheCurrentUser.add(otherUserId);

    await Storage()
        .firestore
        .collection('users')
        .doc(Storage().firebaseAuth.currentUser!.uid)
        .update({"following": followingOfTheCurrentUser});

    await Storage()
        .firestore
        .collection('users')
        .doc(otherUserId)
        .update({"followers": followersOfTheOtherUser});
  }
}
