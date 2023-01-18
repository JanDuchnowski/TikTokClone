import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';

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
    if (followersOfTheOtherUser.contains(currentUserFollower.uid) ||
        followingOfTheCurrentUser.contains(otherUserId)) {
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

    final bool usersAreFriends = await checkIfUsersAreFriends(otherUserId);
    if (usersAreFriends) {
      final List currentUserFriendList = currentUserDocument['friends'];
      final List otherUserFriendList = otherUserDocument['friends'];
      currentUserFriendList.add(otherUserId);
      otherUserFriendList.add(Storage().firebaseAuth.currentUser!.uid);
      await Storage()
          .firestore
          .collection('users')
          .doc(otherUserId)
          .update({"friends": otherUserFriendList});

      await Storage()
          .firestore
          .collection('users')
          .doc(Storage().firebaseAuth.currentUser!.uid)
          .update({"friends": currentUserFriendList});
    }
  }

  Future<bool> checkIfUsersAreFriends(
    String otherUserId,
  ) async {
    final currentUserDocument = await Storage()
        .firestore
        .collection('users')
        .doc(Storage().firebaseAuth.currentUser!.uid)
        .get();
    final List followersOfTheCurrentUser = currentUserDocument['followers'];
    final List followingOfTheCurrentUser = currentUserDocument['following'];

    if (followingOfTheCurrentUser.contains(otherUserId) &&
        followersOfTheCurrentUser.contains(otherUserId)) {
      return true;
    }
    return false;
  }
}
