import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({Key? key, this.dataSource}) : super(key: key);

  final String? dataSource;

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
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return FittedBox(
    //   fit: BoxFit.cover,
    //   child: SizedBox(
    //     height: _controller.value.size.height ?? 1,
    //     width: _controller.value.size.width ?? 1,
    //     child:
    return VideoPlayer(_controller);
  }
}
