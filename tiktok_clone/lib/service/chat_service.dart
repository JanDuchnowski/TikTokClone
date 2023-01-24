import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';

class ChatService {
  final AuthenticationService _authenticationService = AuthenticationService();
  Future<void> sendMessage(String message, String receiverId) async {
    final User? currentUser = await _authenticationService.getCurrentUser();
    Storage()
        .firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('converstions')
        .doc(receiverId);
  }
}
