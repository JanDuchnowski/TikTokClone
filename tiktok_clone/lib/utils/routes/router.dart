import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homeScreenRoute:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case Routes.loginScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case Routes.signupScreenRoute:
      return MaterialPageRoute(builder: (context) => SignupScreen());
    default:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
