import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class VideoController {
  Future<void> fetchPosts() async {
    print("was called");

    await Storage().firestore.collection('posts').get().then((value) =>
        AuthController().videoList =
            value.docs.map((doc) => doc.data()['video'].toString()).toList());

    //final allPosts =
    // querySnapshot.docs.map((doc) => doc.data().toString()).toList();
    // AuthController().videoList = allPosts;
    // print(allPosts);
    //print(AuthController().videoList);
  }
}
