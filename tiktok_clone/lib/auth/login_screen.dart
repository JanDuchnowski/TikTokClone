import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/auth/auth_controller.dart';
import 'package:tiktok_clone/firebase/storage.dart';
import 'package:tiktok_clone/utils/routes/routes_constants.dart';
import 'package:tiktok_clone/views/screens/home/home_screen.dart';
import 'package:tiktok_clone/views/widgets/submit_button.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';
import 'package:tiktok_clone/models/user.dart' as model;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthController().user = (Storage().firebaseAuth.currentUser);
    //TODO mlisten to user signed-in and signed-out events with authStateChanges()
    if (AuthController().user != null) {
      getCurrentUser(Storage().firebaseAuth.currentUser!.uid);
      print("User already logged in");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamed(
            context,
            Routes
                .homeScreenRoute); //This navigates to the home widget embeded in the main
      });
    } else {
      print("User has to login");
    }
  }

  Future<void> getCurrentUser(String uid) async {
    AuthController().currentUser = model.User.fromSnap(
        await Storage().firestore.collection('users').doc(uid).get());
  }

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
              isObscure: true,
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
