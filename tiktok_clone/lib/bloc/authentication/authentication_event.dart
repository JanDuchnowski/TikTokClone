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

class AuthenticationStartedEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
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
