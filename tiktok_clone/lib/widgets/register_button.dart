import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
import 'package:tiktok_clone/service/authentication_service.dart';

import 'package:tiktok_clone/utilities/color_palette.dart';
import 'package:tiktok_clone/utilities/constants.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton(
      {Key? key,
      required this.password,
      required this.email,
      required this.username});

  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController username;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) {
        return Container(
          width: 100,
          height: 50,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: state.authenticationStatus == AuthenticationStatus.notEmpty
                ? ColorPalette.buttonColor
                : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: InkWell(
            onTap: () async {
              if (state.authenticationStatus == AuthenticationStatus.notEmpty) {
                context.read<AuthenticationBloc>().add(RegisterUserEvent(
                    email: email.text,
                    password: password.text,
                    profileImage: state.profileImage!,
                    username: username.text));
              }
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
      }),
    );
  }
}
