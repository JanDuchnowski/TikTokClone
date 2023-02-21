import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  VideoItem({required this.dataSource});
  final String dataSource;
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.dataSource)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _controller!.value.isInitialized
          ? Container(
              width: 100.0,
              height: 56.0,
              child: VideoPlayer(_controller!),
            )
          : CircularProgressIndicator(),
      title: Text("Szyc"),
      onTap: () {},
    );
  }
}
