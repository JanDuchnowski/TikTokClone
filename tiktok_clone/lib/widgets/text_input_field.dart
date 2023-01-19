import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/utilities/color_palette.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.textController,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  final TextEditingController textController;
  final String labelText;
  final bool isObscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: ColorPalette.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: ColorPalette.borderColor,
            ),
          ),
        ),
        obscureText: isObscure,
      ),
    );
  }
}
