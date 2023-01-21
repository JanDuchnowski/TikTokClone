import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/utilities/color_palette.dart';
import 'package:tiktok_clone/utilities/constants.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.password,
    required this.email,
  }) : super(key: key);

  final TextEditingController email;
  final TextEditingController password;

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
          AuthController().loginUser(email.text, password.text, context);
          context.read<AuthenticationBloc>().add(
              AuthenticationStartedEvent()); // poczekać aż state bedzie successfull
          context.read<TiktokBloc>().add(FetchPostsEvent());
          Navigator.of(context).pushNamed(Routes.homeScreenRoute);
        },
        child: const Center(
          child: Text(
            Constants.loginButtonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
