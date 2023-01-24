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
        emit(state.copyWith(authenticationStatus: AuthenticationStatus.fail));
      } else if (event is ProfilePictureChosenEvent) {
        File? profilePhoto = await _authenticationRepository.pickProfileImage();
        if (profilePhoto != null) {
          if (state.authenticationStatus == AuthenticationStatus.notEmpty) {
            emit(state.copyWith(
              profileImage: profilePhoto,
            ));
          } else {
            emit(state.copyWith(
                profileImage: profilePhoto,
                authenticationStatus: AuthenticationStatus.notEmpty));
          }
        }
      }
    });
    on<CredentialsNotEmptyEvent>((event, emit) {
      if (state.profileImage != null) {
        emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.notEmpty,
        ));
      }
    });
    on<CredentialsEmptyEvent>((event, emit) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.empty,
      ));
    });
  }
}
