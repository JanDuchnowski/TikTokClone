import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/service/upload_video_service.dart';

abstract class IUploadVideoRepository {
  Future<void> uploadVideo(String songName, String caption, String videoPath);
}

class UploadVideoRepository implements IUploadVideoRepository {
  final UploadVideoService _uploadVideoService = UploadVideoService();
  @override
  Future<void> uploadVideo(String songName, String caption, String videoPath) {
    return _uploadVideoService.uploadVideo(songName, caption, videoPath);
  }
}
