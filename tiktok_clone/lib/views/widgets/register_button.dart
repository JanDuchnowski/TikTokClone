import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/utils/color_palette.dart';
import 'package:tiktok_clone/views/widgets/submit_button.dart';

class RegisterButton extends SubmitButton {
  const RegisterButton(
      {Key? key,
      required buttonText,
      required password,
      required email,
      required this.username})
      : super(
            key: key, buttonText: buttonText, password: password, email: email);

  final TextEditingController username;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width - 40;
    return Container(
      width: deviceWidth,
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
          if (buttonText == "Register") {
            //TODO get access to text controllers from signup page
            AuthController().registerUser(
              username.text,
              email.text,
              password.text,
              (AuthController().pickedProfileImage),
            );
          }
        },
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
