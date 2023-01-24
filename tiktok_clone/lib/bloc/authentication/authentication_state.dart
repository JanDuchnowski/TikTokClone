part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationChosenPhoto extends AuthenticationState {
  final File profileImage;
  const AuthenticationChosenPhoto({required this.profileImage});

  AuthenticationChosenPhoto copyWith({File? profileImage}) {
    return AuthenticationChosenPhoto(
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final model.User? user;
  const AuthenticationSuccess({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationCredentialsNotEmpty extends AuthenticationChosenPhoto {
  final File profileImage;

  const AuthenticationCredentialsNotEmpty({required this.profileImage})
      : super(profileImage: profileImage);
  @override
  List<Object?> get props => [];
}

class AuthenticationCredentialsEmpty extends AuthenticationChosenPhoto {
  final File profileImage;
  const AuthenticationCredentialsEmpty({required this.profileImage})
      : super(profileImage: profileImage);
  @override
  List<Object?> get props => [];
}
