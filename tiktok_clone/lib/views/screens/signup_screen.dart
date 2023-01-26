import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:tiktok_clone/bloc/authentication/authentication_bloc.dart';
import 'package:tiktok_clone/bloc/tiktok/tiktok_bloc.dart';
import 'package:tiktok_clone/widgets/logo_widget.dart';
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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authenticationStatus == AuthenticationStatus.signedOut) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/signup', (Route<dynamic> route) => false);
          }
          if (state.authenticationStatus == AuthenticationStatus.successful) {
            Navigator.of(context).pushNamed(Routes.homeScreenRoute);
            context.read<TiktokBloc>().add(FetchPostsEvent());
          }
        },
        builder: ((context, state) {
          print(state.authenticationStatus);
          return state.authenticationStatus ==
                  AuthenticationStatus.waitingToRegister
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LogoWidget(),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundImage: (state.profileImage != null) &&
                                      state.authenticationStatus !=
                                          AuthenticationStatus.signedOut
                                  ? FileImage(state.profileImage!)
                                      as ImageProvider
                                  : const NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
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
                                  if (areCredentialsNotEmpty(
                                      "", context, state)) {
                                    context
                                        .read<AuthenticationBloc>()
                                        .add(CredentialsNotEmptyEvent());
                                  }
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "Register",
                        ),
                        TextInputField(
                          textController: _usernameController,
                          labelText: 'Username',
                          icon: Icons.person,
                          onChanged: areCredentialsNotEmpty,
                        ),
                        TextInputField(
                          textController: _emailController,
                          labelText: 'Email',
                          icon: Icons.email,
                          onChanged: areCredentialsNotEmpty,
                        ),
                        TextInputField(
                          textController: _passwordController,
                          labelText: 'Password',
                          icon: Icons.key,
                          isObscure: true,
                          onChanged: areCredentialsNotEmpty,
                        ),
                        RegisterButton(
                          email: _emailController,
                          password: _passwordController,
                          username: _usernameController,
                        ),
                        if (state.authenticationStatus ==
                            AuthenticationStatus.empty)
                          const Text(
                              "Please input all the credentials and choose a photo"),
                        if (state.authenticationStatus ==
                            AuthenticationStatus.invalidEmail)
                          const Text("Please input correct email address"),
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
                  ),
                );
        }),
      ),
    );
  }

  bool areCredentialsNotEmpty(String? value, BuildContext context,
      AuthenticationState authenticationState) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        authenticationState.profileImage != null) {
      if (_isEmailValid(_emailController.text)) {
        context.read<AuthenticationBloc>().add(CredentialsNotEmptyEvent());
        return true;
      } else {
        context.read<AuthenticationBloc>().add(InvalidEmailEvent());
        return false;
      }
    }
    context.read<AuthenticationBloc>().add(CredentialsEmptyEvent());
    return false;
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
