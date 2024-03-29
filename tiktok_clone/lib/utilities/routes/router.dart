import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/views/screens/conversations_list_screen.dart';
import 'package:tiktok_clone/views/screens/friends_page.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';

import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/views/screens/signup_screen.dart';
import 'package:tiktok_clone/views/video/add_video_screen.dart';
import 'package:tiktok_clone/tiktok_feed.dart';

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
    default:
      return MaterialPageRoute(builder: (context) => TikTokFeed());
  }
}
