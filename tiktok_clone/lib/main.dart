import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/utilities/color_palette.dart';
import 'package:tiktok_clone/utilities/routes/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Storage().camerasList = await availableCameras();

  runApp(TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp();

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
