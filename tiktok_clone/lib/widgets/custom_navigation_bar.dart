import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok_bloc.dart';

import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/profile/presentation/profile_screen.dart';
import 'package:tiktok_clone/utilities/color_palette.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/widgets/custom_plus_icon.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({
    Key? key,
    required this.currentlySelected,
  }) : super(key: key);

  final int currentlySelected;
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPalette.backgroundColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.red,
      currentIndex: widget.currentlySelected,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle_outlined,
              size: 30,
            ),
            label: 'Friends'),
        BottomNavigationBarItem(
          icon: CustomPlusIcon(),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: 'Inbox'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile'),
      ],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          context.read<TiktokBloc>().add(FetchPostsEvent());
          Navigator.pushNamed(context, Routes.homeScreenRoute);
          break;
        case 1:
          context.read<TiktokBloc>().add(const FetchFriendsPostsEvent());
          Navigator.pushNamed(context, Routes.friendsPageRoute);
          break;
        case 2:
          Navigator.pushNamed(context, Routes.videoPickerRoute);
          break;

        case 3:
          Navigator.pushNamed(context, Routes.conversationsScreenRoute);
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                  userId: Storage().firebaseAuth.currentUser!.uid),
            ),
          );
          break;
        default:
          break;
      }
    });
  }
}
