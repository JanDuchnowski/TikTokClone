part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfilePictureChosenEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;
  final File profileImage;

  RegisterUserEvent(
      {required this.email,
      required this.password,
      required this.profileImage,
      required this.username});
  @override
  List<Object> get props => [email, password, username, profileImage];
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignedOutEvent extends AuthenticationEvent {
  final BuildContext context;
  AuthenticationSignedOutEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class CredentialsNotEmptyEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class CredentialsEmptyEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class InvalidEmailEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class FetchLogoEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
