import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CamerPreviewScreen extends StatefulWidget {
  @override
  _CamerPreviewScreenState createState() => _CamerPreviewScreenState();
}

class _CamerPreviewScreenState extends State<CamerPreviewScreen> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for caputred image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            child: controller == null
                ? const Center(child: Text("Loading Camera..."))
                : !controller!.value.isInitialized
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Transform.scale(
                        //To make camera preview fullscreen
                        scale: 1 /
                            (controller!.value.aspectRatio *
                                MediaQuery.of(context).size.aspectRatio),
                        alignment: Alignment.topCenter,
                        child: CameraPreview(controller!),
                      ),
          ),
          // Container(
          //   //show captured image
          //   padding: const EdgeInsets.all(30),
          //   child: image == null
          //       ? const Text("No image captured")
          //       : Image.file(
          //           File(image!.path),
          //           height: 300,
          //         ), //handle io for web
          //   //display captured image
          // )

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: (() {}),
              child: Text("Take a photo"),
            ),
          )
        ],
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () async {
    //     try {
    //       if (controller != null) {
    //         //check if contrller is not null
    //         if (controller!.value.isInitialized) {
    //           //check if controller is initialized
    //           image = await controller!.takePicture(); //capture image
    //           setState(() {
    //             //update UI
    //           });
    //         }
    //       }
    //     } catch (e) {
    //       print(e); //show error
    //     }
    //   },
    //   child: const Icon(Icons.camera),
    // ),
  }
}
