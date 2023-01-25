import 'package:flutter/material.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/widgets/login_button.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/widgets/logo_widget.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(),
              const Text("Login"),
              TextInputField(
                textController: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
              TextInputField(
                textController: _passwordController,
                isObscure: true,
                labelText: 'Password',
                icon: Icons.key,
              ),
              LoginButton(
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
      ),
    );
  }
}
