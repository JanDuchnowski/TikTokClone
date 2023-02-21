import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({Key? key, this.dataSource, this.playVideo = true})
      : super(key: key);

  final String? dataSource;
  final bool playVideo;
  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.dataSource!);

    _controller.addListener(() {});
    _controller.setLooping(true);
    _controller.initialize();
    if (widget.playVideo) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    print("Disposed called");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }
}
