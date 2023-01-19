import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class PostService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostStream() {
    return Storage().firestore.collection('posts').snapshots();
  }
}
