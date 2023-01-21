import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/widgets/register_button.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Register Screen"),
                const SizedBox(
                  height: 32,
                ),
                const Text("Register"),
                const SizedBox(
                  height: 32,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: state is AuthenticationChosenPhoto
                          ? FileImage(state.profileImage) as ImageProvider
                          : const NetworkImage(
                              'https://ynnovate.it/wp-content/uploads/2015/07/default-avatar1.png'),
                      backgroundColor: Colors.white,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () async {
                          context
                              .read<AuthenticationBloc>()
                              .add(ProfilePictureChosenEvent());
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                TextInputField(
                    textController: _usernameController,
                    labelText: 'Username',
                    icon: Icons.person),
                TextInputField(
                  textController: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
                TextInputField(
                  textController: _passwordController,
                  labelText: 'Password',
                  icon: Icons.key,
                  isObscure: true,
                ),
                RegisterButton(
                  email: _emailController,
                  password: _passwordController,
                  username: _usernameController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.loginScreenRoute,
                        );
                      },
                      child: const Text(
                        "Login",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
