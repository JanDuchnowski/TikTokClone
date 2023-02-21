
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/repository/upload_video_repository.dart';

class AudioPicker extends StatefulWidget {
  const AudioPicker({Key? key}) : super(key: key);

  @override
  State<AudioPicker> createState() => _AudioPickerState();
}

class _AudioPickerState extends State<AudioPicker> {
  List<String>? audioList;

  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    asyncInitState();
    super.initState();
  }

  void asyncInitState() async {
    audioList = await (context.read<UploadVideoRepository>().getAudioList());

    //player.setSourceAsset("audio/");
  }

  @override
  Widget build(BuildContext context) {
    // rootBundle.
    // return audioList != null
    return ListView(
      shrinkWrap: true,
      children: [
        TextButton(
            onPressed: () {
              player.play(AssetSource("audio/audio1.mp3"));
            },
            child: const Text("Test"))
      ],
    );
  }
}
