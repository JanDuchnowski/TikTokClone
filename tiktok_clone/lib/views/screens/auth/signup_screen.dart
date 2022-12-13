import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/utils/color_palette.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/submit_button.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

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
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://ynnovate.it/wp-content/uploads/2015/07/default-avatar1.png'),
                  backgroundColor: Colors.white,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      print("Pick an image");
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
            const SubmitButton(buttonText: "Register"),
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
