part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class FetchProfileEvent extends ProfileEvent {
  final String uid;
  FetchProfileEvent({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class FollowUserEvent extends ProfileEvent {
  final String otherUserId;

  FollowUserEvent({required this.otherUserId});
  @override
  List<Object?> get props => [otherUserId];
}

class FetchProfilePostsEvent extends ProfileEvent {
  final String uid;
  FetchProfilePostsEvent({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class FetchFollowersEvent extends ProfileEvent {
  final User profileUser;

  FetchFollowersEvent({required this.profileUser});
  @override
  List<Object?> get props => [profileUser];
}

class FetchFollowingEvent extends ProfileEvent {
  final User profileUser;

  FetchFollowingEvent({required this.profileUser});
  @override
  List<Object?> get props => [profileUser];
}
