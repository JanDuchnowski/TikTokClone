import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/utils/color_palette.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/views/widgets/custom_plus_icon.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorPalette.backgroundColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.red,
      currentIndex: _selectedIndex,
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
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          Navigator.pushNamed(context, Routes.videoPickerRoute);
          break;

        case 3:
          Navigator.pushNamed(context, Routes.conversationsScreenRoute);
          break;
        default:
          break;
      }
      print(_selectedIndex);
    });
  }
}
