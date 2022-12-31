import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController {
  static final AuthController _singleton = AuthController._internal();

  factory AuthController() {
    return _singleton;
  }

  AuthController._internal();

  File? pickedProfileImage;
  User? user;
  File? getProfileImage() {
    return pickedProfileImage;
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      //TODO using bloc change state to loading image state
      print("You have successfully selected a picture");
    }

    pickedProfileImage = File(pickedImage!.path);
  }

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

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
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
        print("Error registering");
        print("You forgot to input some credentials");
      }
    } catch (e) {
      print("Error registering");
    }
  }

  void loginUser(String email, String password, BuildContext context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await Storage()
            .firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        print("Successful login");

        Navigator.pushNamed(context, Routes.homeScreenRoute);
      } else {
        print("Error logging in");
        print("Please input all the credentials");
      }
    } catch (e) {
      print(e);
    }
  }
}
