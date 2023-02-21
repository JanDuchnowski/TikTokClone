import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PostThumbnail extends StatefulWidget {
  const PostThumbnail({Key? key, this.video}) : super(key: key);
  final Video? video;

  @override
  State<PostThumbnail> createState() => _PostThumbnailState();
}

class _PostThumbnailState extends State<PostThumbnail> {
  Future<Image>? _future;

  @override
  void initState() {
    _future = generateThumbnail(widget.video!.videoUrl);
    super.initState();
  }

  Future<Image> generateThumbnail(String videoUrl) async {
    final bytes = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    final Image thumbnailImage = Image.memory(bytes!);
    return thumbnailImage;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Image;
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Text("No image can be generated");
        }
      },
    );
  }
}
