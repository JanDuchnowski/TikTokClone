import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/video_tiktok.dart';

class FileLoader extends StatefulWidget {
  const FileLoader({Key? key}) : super(key: key);

  @override
  State<FileLoader> createState() => _FileLoaderState();
}

class _FileLoaderState extends State<FileLoader> {
  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    uploadFile();
    fetchFiles();
  }

  Future fetchFiles() async {
    final ref = Storage().firebaseStorage.ref().child(
        'gs://tiktokclone-c2cf7.appspot.com/files/data/user/0/com.example.tiktok_clone/cache/file_picker/IMG_4900.HEIC');
    print("filename " + pickedFile!.name);
    var url = await ref.getDownloadURL();
    print(url);
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.path}';
    final file = File(pickedFile!.path!);

    final ref1 = Storage().firebaseStorage.ref().child(path);
    Storage().firebaseStorage.ref().child('files/');

    //  final ref = FirebaseStorage.instance.ref().child(path);

    await ref1.putFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (pickedFile != null)
            TikTokContent(
              pickedFile: pickedFile,
            ),
          ElevatedButton(
            child: Text("Upload"),
            onPressed: () {
              selectFile();
            },
          ),
        ],
      ),
    );
  }
}
