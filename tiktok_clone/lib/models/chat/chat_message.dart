import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
    };
  }

  factory ChatMessages.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ChatMessages(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      timestamp: snapshot['timestamp'],
      content: snapshot['content'],
      type: snapshot['type'],
    );
  }
}
