import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/service/profile_service.dart';

abstract class ProfileRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(String uid);
  Future<void> followUser(String userToFollowId);
  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchUserPosts(String uid);
}

class ProfileRepository extends ProfileRepositoryInterface {
  final ProfileService _profileService;

  ProfileRepository({ProfileService? profileService})
      : _profileService = profileService ?? ProfileService();

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return _profileService.getProfileInfoStream(uid);
  }

  @override
  Future<void> followUser(String userToFollowId) {
    return _profileService.followUser(userToFollowId);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? fetchUserPosts(String uid) {
    return _profileService.fetchUserPosts(uid);
  }
}
