import 'dart:developer';
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
      : super(const AuthenticationState.initial()) {
    on<FetchLogoEvent>(
      (event, emit) async {
        final String? logoUrl = await _authenticationRepository.fetchLogo();
        emit(state.copyWith(logoUrl: logoUrl!));
      },
    );
    on<RegisterUserEvent>((event, emit) async {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.waitingToRegister));
      await _authenticationRepository.registerUser(
          event.username, event.email, event.password, event.profileImage);

      model.User? user = await _authenticationRepository.getCurrentUser();

      if (user != null) {
        _authenticationRepository.loginUser(event.email, event.password);
        emit(state.copyWith(
            user: user, authenticationStatus: AuthenticationStatus.successful));
      } else {
        emit(state.copyWith(authenticationStatus: AuthenticationStatus.fail));
      }
    });
    on<LoginEvent>((event, emit) async {
      model.User? user = await _authenticationRepository.getCurrentUser();

      if (user != null) {
        _authenticationRepository.loginUser(event.email, event.password);
        emit(state.copyWith(
            user: user, authenticationStatus: AuthenticationStatus.successful));
      } else {
        emit(state.copyWith(authenticationStatus: AuthenticationStatus.fail));
      }
    });
    on<AuthenticationSignedOutEvent>(
      (event, emit) {
        emit(state.copyWith(
            authenticationStatus: AuthenticationStatus.signedOut,
            profileImage: null));
      },
    );

    on<ProfilePictureChosenEvent>(
      (event, emit) async {
        File? profilePhoto = await _authenticationRepository.pickProfileImage();
        if (profilePhoto != null) {
          emit(state.copyWith(
            profileImage: profilePhoto,
          ));
        }
      },
    );

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
