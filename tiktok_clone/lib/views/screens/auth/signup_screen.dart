import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tiktok_clone/controllers/auth_controller.dart';

import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/register_button.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  backgroundImage: AuthController().pickedProfileImage == null
                      ? const NetworkImage(
                          'https://ynnovate.it/wp-content/uploads/2015/07/default-avatar1.png')
                      : FileImage(
                              File(AuthController().pickedProfileImage!.path))
                          as ImageProvider,
                  backgroundColor: Colors.white,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () async {
                      await AuthController().pickImage();
                      //TODO add bloc to refresh the state when a picture is chosen
                      setState(() {});
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
            ),
            RegisterButton(
              buttonText: "Register",
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
                    print("Go back to login page button pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
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
      ),
    );
  }
}
