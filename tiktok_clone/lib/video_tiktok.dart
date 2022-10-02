import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TikTokContent extends StatelessWidget {
  const TikTokContent({Key? key, this.pickedFile}) : super(key: key);
  final PlatformFile? pickedFile;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Image.file(File(pickedFile!.path!)),
        ],
      ),
    );
  }
}
