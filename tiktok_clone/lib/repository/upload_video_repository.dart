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
