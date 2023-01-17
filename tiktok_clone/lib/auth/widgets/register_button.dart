import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';

import 'package:tiktok_clone/utilities/color_palette.dart';
import 'package:tiktok_clone/utilities/constants.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {Key? key,
      required this.password,
      required this.email,
      required this.username});

  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController username;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: ColorPalette.buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: InkWell(
        onTap: () {
          //TODO get access to text controllers from signup page
          AuthController().registerUser(
            username.text,
            email.text,
            password.text,
            (AuthController().pickedProfileImage),
          );
        },
        child: const Center(
          child: Text(
            Constants.registerButtonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}