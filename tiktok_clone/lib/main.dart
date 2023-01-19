import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/app_bloc_observer.dart';
import 'package:tiktok_clone/auth/bloc/authentication_bloc.dart';
import 'package:tiktok_clone/auth/repository/authentication_repository.dart';
import 'package:tiktok_clone/bloc/tiktok_bloc.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/repository/post_repository.dart';
import 'package:tiktok_clone/test.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(AuthenticationRepository()),
        ),
        BlocProvider(
          create: ((context) => TiktokBloc(PostRepository())),
        ),
      ],
      child: const TikTokApp(),
    ),
  );
  Bloc.observer = AppBlocObserver();
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({Key? key}) : super(key: key);

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
