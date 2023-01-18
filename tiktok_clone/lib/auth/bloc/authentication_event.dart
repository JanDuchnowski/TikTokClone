part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
