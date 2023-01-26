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
    final User? currentUser = User.fromSnap(currentUserDocument);
    final User? otherUser = User.fromSnap(otherUserDocument);

    final List followersOfTheOtherUser = otherUserDocument['followers'];
    final List followingOfTheCurrentUser = currentUserDocument['following'];
    if (followersOfTheOtherUser.contains(currentUser) ||
        followingOfTheCurrentUser.contains(otherUser)) {
      followersOfTheOtherUser.remove(currentUser);
      followingOfTheCurrentUser.remove(otherUser);

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
    followersOfTheOtherUser.add(currentUser);
    followingOfTheCurrentUser.add(otherUser);

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
      currentUserFriendList.add(otherUser);
      otherUserFriendList.add(currentUser);
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

  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchUserPosts(String uid) {
    return Storage()
        .firestore
        .collection("users")
        .doc(uid)
        .collection("posts")
        .snapshots();
  }
}
