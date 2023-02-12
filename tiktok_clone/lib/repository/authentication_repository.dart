import 'dart:io';

import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/models/user/user.dart';

abstract class AuthenticationRepositoryInterface {
  Future<User?> getCurrentUser();
  Future<File?> pickProfileImage();
  Future<void> registerUser(
      String username, String email, String password, File? image);
  Future<String?> fetchLogo();
  void loginUser(String email, String password);
}

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final AuthenticationService _authenticationService = AuthenticationService();
  @override
  Future<User?> getCurrentUser() {
    return _authenticationService.getCurrentUser();
  }

  @override
  Future<File?> pickProfileImage() {
    return _authenticationService.pickImage();
  }

  @override
  Future<void> registerUser(
      String username, String email, String password, File? image) {
    return _authenticationService.registerUser(
        username, email, password, image);
  }

  @override
  Future<String?> fetchLogo() {
    return _authenticationService.fetchLogo();
  }

  @override
  void loginUser(String email, String password) {
    return _authenticationService.loginUser(email, password);
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
