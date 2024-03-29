import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';

class ProfileService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return Storage()
        .firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

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
    followersOfTheOtherUser.add(Storage().firebaseAuth.currentUser!.uid);
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
