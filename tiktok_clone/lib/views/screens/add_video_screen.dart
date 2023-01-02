import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/take_photo_screen.dart';

class AddVideoScreen extends StatefulWidget {
  AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [TakePictureScreen()]),
    );
  }
}
