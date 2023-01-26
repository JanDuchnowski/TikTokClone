import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart' as model;
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';

class AuthenticationService {
  File? pickedProfileImage;
  model.User? currentUser;

  Future<model.User?> getCurrentUser() async {
    if (Storage().firebaseAuth.currentUser != null) {
      print(" I am here");
      try {
        final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await Storage()
                .firestore
                .collection('users')
                .doc(Storage().firebaseAuth.currentUser!.uid)
                .get();
        currentUser = model.User.fromSnap(userSnapshot);
      } catch (e) {
        print(e);
      }
    }

    return currentUser;
  }

  Future<File?> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print("You have successfully selected a picture");
      pickedProfileImage = File(pickedImage.path);
      return pickedProfileImage;
    }
  }

  Future<String> _uploadToStorage(File image, String folder) async {
    print("Got to uploading the image to storage");

    final Reference ref = Storage()
        .firebaseStorage
        .ref()
        .child(folder)
        .child(Storage().firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential
            userCredential = //TODO utilize the additional errors provided by the function
            await Storage().firebaseAuth.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
        String downloadUrl = await _uploadToStorage(image, 'profilPics');
        model.User user = model.User(
          name: username,
          email: email,
          uid: userCredential.user!.uid,
          profilePhoto: downloadUrl,
          likes: 0,
          followers: [],
          following: [],
          friends: [],
          currentlyLikedPosts: [],
        );
        await Storage()
            .firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        print("successfully registered the user in cloud firestore");
      } else {
        print("You forgot to input some credentials");
      }
    } catch (e) {
      print(e);
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await Storage()
            .firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        print("Successful login");
      } else {
        print("Error logging in");
        print("Please input all the credentials");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await Storage().firebaseAuth.signOut();
  }

  Future<String?> fetchLogo() async {
    final ref = Storage().firebaseStorage.ref().child('icon').child('icon.png');
    final downloadUrl = ref.getDownloadURL();
    return downloadUrl;
  }
}
