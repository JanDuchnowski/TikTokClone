import 'dart:io';

import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/models/user/user.dart';

abstract class AuthenticationRepositoryInterface {
  Future<User?> getCurrentUser();
  Future<File?> pickProfileImage();
}

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  @override
  Future<User?> getCurrentUser() {
    return AuthController().getCurrentUser();
  }

  @override
  Future<File?> pickProfileImage() {
    return AuthController().pickImage();
  }
}



// import 'package:firebase_auth/firebase_auth.dart';

// class AuthenticationRepositoryImpl implements AuthenticationRepository {
//   DatabaseService dbService = DatabaseService(); //should depend on abstraction

//   @override
//   Stream<User> getCurrentUser() {
//     return service.retrieveCurrentUser();
//   }

//   @override
//   Future<UserCredential?> signUp(User user) {
//     try {
//       return service.signUp(user);
//     } on FirebaseAuthException catch (e) {
//       throw FirebaseAuthException(code: e.code, message: e.message);
//     }
//   }

//   @override
//   Future<UserCredential?> signIn(User user) {
//     try {
//       return service.signIn(user);
//     } on FirebaseAuthException catch (e) {
//       throw FirebaseAuthException(code: e.code, message: e.message);
//     }
//   }

//   @override
//   Future<void> signOut() {
//     return service.signOut();
//   }

//   @override
//   Future<String?> retrieveUserName(UserModel user) {
//     return dbService.retrieveUserName(user);
//   }
// }

// abstract class AuthenticationRepository {
//   Stream<User> getCurrentUser();
//   Future<UserCredential?> signUp(User user);
//   Future<UserCredential?> signIn(User user);
//   Future<void> signOut();
//   Future<String?> retrieveUserName(User user);
// }
