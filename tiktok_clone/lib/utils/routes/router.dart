import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/chat/conversations_list_screen.dart';
import 'package:tiktok_clone/friends/friends_page.dart';
import 'package:tiktok_clone/profile/profile_screen.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/auth/login_screen.dart';
import 'package:tiktok_clone/auth/signup_screen.dart';
import 'package:tiktok_clone/video/add_video_screen.dart';
import 'package:tiktok_clone/views/screens/home/home_screen.dart';
import 'package:tiktok_clone/views/screens/home/tiktok_feed.dart';

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
    case Routes.conversationsScreenRoute:
      return MaterialPageRoute(builder: (context) => ConversationsListScreen());
    case Routes.friendsPageRoute:
      return MaterialPageRoute(builder: (context) => FriendsPage());
    //  case Routes.profileScreenRoute:
    //   return MaterialPageRoute(builder: (context) {
    //      return ProfileScreen(user: AuthController().currentUser!);
    // });
    default:
      return MaterialPageRoute(builder: (context) => TikTokFeed());
  }
}
