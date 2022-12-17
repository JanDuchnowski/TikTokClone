import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart' as model;

Future<String> _uploadToStorage(File image) async {
  Reference ref = Storage()
      .firebaseStorage
      .ref()
      .child('profilPics')
      .child(Storage().firebaseAuth.currentUser!.uid);

  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snap =
      await uploadTask; //TODO fully understand what this snap holds (what upload)
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}

class AuthController {
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isEmpty &&
          image != null) {
        //TODO save the user to our auth and firebase
        UserCredential userCredential =
            await Storage().firebaseAuth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          email: email,
          uid: userCredential.user!.uid,
          profilePhoto: downloadUrl,
        );
        await Storage()
            .firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      } else {
        print("You forgot to input some credentials");
      }
    } catch (e) {}
  }
}
