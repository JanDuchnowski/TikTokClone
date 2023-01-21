part of 'tiktok_bloc.dart';

abstract class TiktokEvent extends Equatable {
  const TiktokEvent();
}

class FetchPostsEvent extends TiktokEvent {
  @override
  List<Object?> get props => [];
}

class LikePostEvent extends TiktokEvent {
  final String postId;

  const LikePostEvent({required this.postId});
  @override
  List<Object?> get props => [];
}

class FetchFriendsPostsEvent extends TiktokEvent {
  const FetchFriendsPostsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfileEvent extends TiktokEvent {
  final String uid;
  const FetchProfileEvent({required this.uid});
  @override
  List<Object?> get props => [];
}
