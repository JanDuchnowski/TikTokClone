import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/video.dart';

class UploadVideoController {
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = Storage().firebaseStorage.ref().child('posts').child(id);

    UploadTask uploadTask = ref.putFile(File(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadVideo(
      String songName, String caption, String videoPath) async {
    try {
      String uid = Storage().firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await Storage().firestore.collection('users').doc(uid).get();

      var allDocs = await Storage().firestore.collection('posts').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        comments: [],
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await Storage().firestore.collection('posts').doc('Video $len').set(
            video.toJson(),
          );
      await Storage()
          .firestore
          .collection('users')
          .doc((userDoc.data()! as Map<String, dynamic>)['uid'])
          .collection('posts')
          .doc('Video $len')
          .set(
            video.toJson(),
          );
    } catch (e) {
      print(e);
    }
  }
}
