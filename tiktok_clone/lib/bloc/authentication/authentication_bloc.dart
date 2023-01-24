import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
import 'package:tiktok_clone/models/user/user.dart' as model;
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/views/screens/signup_screen.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryInterface _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationState.initial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStartedEvent) {
        model.User? user = await _authenticationRepository.getCurrentUser();

        if (user != null) {
          emit(state.copyWith(
              user: user,
              authenticationStatus: AuthenticationStatus.successful));
        } else {
          emit(state.copyWith(authenticationStatus: AuthenticationStatus.fail));
        }
      } else if (event is AuthenticationSignedOutEvent) {
        emit(state.copyWith(
            authenticationStatus: AuthenticationStatus.signedOut));
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignupScreen()),
            (Route<dynamic> route) => false);
      } else if (event is ProfilePictureChosenEvent) {
        File? profilePhoto = await _authenticationRepository.pickProfileImage();
        if (profilePhoto != null) {
          emit(state.copyWith(
            profileImage: profilePhoto,
          ));
        }
      }
    });
    on<CredentialsNotEmptyEvent>((event, emit) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.notEmpty,
      ));
    });
    on<CredentialsEmptyEvent>((event, emit) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.empty,
      ));
    });
    on<InvalidEmailEvent>((event, emit) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.invalidEmail,
      ));
    });
  }
}
