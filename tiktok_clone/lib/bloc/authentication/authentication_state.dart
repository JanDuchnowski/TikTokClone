part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial,
  empty,
  notEmpty,
  successful,
  fail,
  invalidEmail,
  signedOut
}

class AuthenticationState extends Equatable {
  final File? profileImage;
  final AuthenticationStatus? authenticationStatus;
  final model.User? user;
  const AuthenticationState(
      {this.profileImage, this.authenticationStatus, this.user});

  const AuthenticationState.initial()
      : authenticationStatus = AuthenticationStatus.initial,
        profileImage = null,
        user = null;

  AuthenticationState copyWith(
      {File? profileImage,
      AuthenticationStatus? authenticationStatus,
      model.User? user}) {
    return AuthenticationState(
        profileImage: profileImage ?? this.profileImage,
        authenticationStatus: authenticationStatus ?? this.authenticationStatus,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [profileImage, authenticationStatus, user];
}
