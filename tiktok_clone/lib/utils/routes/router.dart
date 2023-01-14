import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/auth/login_screen.dart';
import 'package:tiktok_clone/auth/signup_screen.dart';
import 'package:tiktok_clone/views/screens/home/home_screen.dart';
import 'package:tiktok_clone/views/screens/home/tiktok_feed.dart';
import 'package:tiktok_clone/views/screens/video/add_video_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homeScreenRoute:
      return MaterialPageRoute(builder: (context) => TikTokFeed());
    case Routes.loginScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case Routes.signupScreenRoute:
      return MaterialPageRoute(builder: (context) => SignupScreen());
    case Routes.videoPickerRoute:
      return MaterialPageRoute(builder: (context) => const AddVideoScreen());
    default:
      return MaterialPageRoute(builder: (context) => TikTokFeed());
  }
}
