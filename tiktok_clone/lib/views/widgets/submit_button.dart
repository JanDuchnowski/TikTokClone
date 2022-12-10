import 'package:flutter/material.dart';
import 'package:tiktok_clone/utils/color_palette.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  final String buttonText;
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
          print(buttonText);
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
