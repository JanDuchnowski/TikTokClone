import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/submit_button.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Screen"),
            const SizedBox(
              height: 32,
            ),
            const Text("Login"),
            const SizedBox(
              height: 32,
            ),
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
            SubmitButton(
              buttonText: "Login",
              email: _emailController,
              password: _passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have account yet?'),
                TextButton(
                  onPressed: () {
                    print("Register button pressed");
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Register",
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
