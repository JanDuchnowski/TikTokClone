import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/chat/presentation/conversations_list_screen.dart';
import 'package:tiktok_clone/friends/friends_page.dart';
import 'package:tiktok_clone/profile/presentation/profile_screen.dart';

import 'package:tiktok_clone/auth/presentation/login_screen.dart';
import 'package:tiktok_clone/auth/presentation/signup_screen.dart';
import 'package:tiktok_clone/test.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/video/presentation/add_video_screen.dart';
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
    // case Routes.friendsPageRoute:
    //   return MaterialPageRoute(builder: (context) => FriendsPage());
    default:
      return MaterialPageRoute(builder: (context) => TikTokFeed());
  }
}
