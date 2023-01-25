part of 'profile_bloc.dart';

@immutable
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
