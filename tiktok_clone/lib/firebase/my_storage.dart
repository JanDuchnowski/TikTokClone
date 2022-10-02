import 'package:firebase_storage/firebase_storage.dart';

class MyStorage {
  static final MyStorage _singleton = MyStorage._internal();

  final storage = FirebaseStorage.instance;

  factory MyStorage() {
    return _singleton;
  }

  MyStorage._internal();
}
