import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/widgets/login_button.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';
import 'package:tiktok_clone/widgets/logo_widget.dart';
import 'package:tiktok_clone/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.authenticationStatus == AuthenticationStatus.successful) {
              context.read<TiktokBloc>().add(FetchPostsEvent());
              Navigator.of(context).pushNamed(Routes.homeScreenRoute);
            }
          },
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
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
                  if (state.authenticationStatus == AuthenticationStatus.fail)
                    const Text(
                      "No such user, please register first or input correct credentials",
                    ),
                  const SizedBox(height: 10),
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
            );
          },
        ),
      ),
    );
  }
}
