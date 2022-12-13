import 'package:flutter/material.dart';
import 'package:tiktok_clone/file_manager/file_loader.dart';
import 'package:tiktok_clone/utils/color_palette.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TikTokApp());
}

/// Stateful widget to fetch and then display video content.
class TikTokApp extends StatefulWidget {
  TikTokApp();

  @override
  _TikTokAppState createState() => _TikTokAppState();
}

class _TikTokAppState extends State<TikTokApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
      home: SignupScreen(),
    );
  }
}
