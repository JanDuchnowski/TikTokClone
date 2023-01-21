import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
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
      if (event is AuthenticationStartedEvent) {
        model.User? user = await _authenticationRepository.getCurrentUser();

        if (user != null) {
          emit(AuthenticationSuccess(user: user));
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOutEvent) {
        emit(AuthenticationFailure());
      } else if (event is ProfilePictureChosenEvent) {
        File? profilePhoto = await _authenticationRepository.pickProfileImage();
        if (profilePhoto != null) {
          emit(AuthenticationChosenPhoto(profileImage: profilePhoto));
        }
      }
    });
  }
}
