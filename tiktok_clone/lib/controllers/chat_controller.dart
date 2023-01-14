import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';

class ChatController{

Future<void> sendMessage(String message, String receiverId) async{

  Storage().firestore.collection('users').doc(AuthController().user!.uid).collection('converstions').doc(receiverId)

}

}