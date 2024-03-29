import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
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
  final AuthenticationService _authenticationService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) {
        if (state is AuthenticationChosenPhoto) {
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
                _authenticationService.registerUser(
                  username.text,
                  email.text,
                  password.text,
                  (_authenticationService.pickedProfileImage),
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
        return Text("Please input all the credentials and a photo");
      }),
    );
  }
}
