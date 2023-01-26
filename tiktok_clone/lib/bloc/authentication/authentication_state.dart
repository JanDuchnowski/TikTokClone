part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  initial,
  empty,
  notEmpty,
  waitingToRegister,
  successful,
  fail,
  invalidEmail,
  signedOut
}

class AuthenticationState extends Equatable {
  final File? profileImage;
  final AuthenticationStatus? authenticationStatus;
  final model.User? user;
  final String? logoUrl;
  const AuthenticationState(
      {this.profileImage, this.authenticationStatus, this.user, this.logoUrl});

  const AuthenticationState.initial()
      : authenticationStatus = AuthenticationStatus.initial,
        profileImage = null,
        user = null,
        logoUrl = '';

  AuthenticationState copyWith(
      {File? profileImage,
      AuthenticationStatus? authenticationStatus,
      model.User? user,
      String? logoUrl}) {
    return AuthenticationState(
        profileImage: profileImage ?? this.profileImage,
        authenticationStatus: authenticationStatus ?? this.authenticationStatus,
        user: user ?? this.user,
        logoUrl: logoUrl ?? this.logoUrl);
  }

  @override
  List<Object?> get props =>
      [profileImage, authenticationStatus, user, logoUrl];
}
