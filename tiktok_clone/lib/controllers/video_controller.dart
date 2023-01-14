import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController {
  static final VideoController _singleton = VideoController._internal();

  factory VideoController() {
    return _singleton;
  }
  late List<Video> videoList;
  VideoController._internal();
  // Future<void> fetchPosts() async {
  //   print("was called");

  //   final snapshot = await Storage().firestore.collection('posts').get();
  //   videoList = snapshot.docs.map((doc) => Video.fromSnap(doc)).toList();
  // }
}
