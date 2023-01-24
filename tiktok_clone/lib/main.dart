import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/app_bloc_observer.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/comment/comment_bloc.dart';
import 'package:tiktok_clone/bloc/profile/profile_bloc.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/repository/comment_repository.dart';
import 'package:tiktok_clone/repository/post_repository.dart';
import 'package:tiktok_clone/repository/profile_repository.dart';
import 'package:tiktok_clone/service/profile_service.dart';
import 'package:tiktok_clone/repository/upload_video_repository.dart';
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

  runApp(RepositoryProvider(
    create: ((context) => UploadVideoRepository()),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(AuthenticationRepository())),
        BlocProvider(
            create: ((context) =>
                TiktokBloc(PostRepository(), AuthenticationRepository()))),
        BlocProvider(
            create: ((context) =>
                CommentBloc(CommentRepository(), AuthenticationRepository()))),
        BlocProvider(
            create: ((context) =>
                ProfileBloc(ProfileRepository(), AuthenticationRepository()))),
      ],
      child: const TikTokApp(),
    ),
  ));
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
