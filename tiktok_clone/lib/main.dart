import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/utils/color_palette.dart';
import 'package:tiktok_clone/utils/routes/router.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Storage().camerasList = await availableCameras();

  runApp(TikTokApp());
}

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
      onGenerateRoute: generateRoute,
      initialRoute: Routes.signupScreenRoute,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorPalette.backgroundColor,
      ),
    );
  }
}
