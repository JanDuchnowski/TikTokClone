import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/service/profile_service.dart';

abstract class ProfileRepositoryInterface {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(String uid);
}

class ProfileRepository extends ProfileRepositoryInterface {
  final ProfileService _profileService = ProfileService();
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return _profileService.getProfileInfoStream(uid);
  }
}
