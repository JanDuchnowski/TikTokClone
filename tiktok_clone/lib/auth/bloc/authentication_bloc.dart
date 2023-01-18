import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/auth/repository/authentication_repository.dart';
import 'package:tiktok_clone/models/user/user.dart' as model;
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        model.User? user = await _authenticationRepository.getCurrentUser();

        if (user != null) {
          print('got here');
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        // await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
