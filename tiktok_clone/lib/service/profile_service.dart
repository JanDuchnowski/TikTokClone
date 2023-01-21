import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class ProfileService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getProfileInfoStream(
      String uid) {
    return Storage()
        .firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
