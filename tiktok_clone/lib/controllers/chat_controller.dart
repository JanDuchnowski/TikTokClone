import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';

class ChatController {
  Future<void> sendMessage(String message, String receiverId) async {
    final User? currentUser = await AuthController().getCurrentUser();
    Storage()
        .firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('converstions')
        .doc(receiverId);
  }
}
