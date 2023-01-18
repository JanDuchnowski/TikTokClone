import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/authentication_bloc.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/utilities/routes/routes_constants.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            Navigator.of(context).pushNamed(Routes.signupScreenRoute);
          }
        },
        buildWhen: ((previous, current) {
          if (current is AuthenticationSuccess) {
            return true;
          }
          return false;
        }),
        builder: (context, state) {
          return Text((state is AuthenticationSuccess).toString());
          // if (state is AuthenticationInitial) {
          //   return Text("Initial");
          // } else if (state is AuthenticationSuccess) {
          //   return Text("Success");
          // }
          // return Text("Nothing");
        },
      ),
    );
  }
}
