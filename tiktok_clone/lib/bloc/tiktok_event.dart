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

class FetchCommentsEvent extends TiktokEvent {
  final String postId;

  const FetchCommentsEvent({required this.postId});
  @override
  List<Object?> get props => [];
}

class PostCommentEvent extends TiktokEvent {
  final String commentText;
  final String postId;
  const PostCommentEvent({required this.commentText, required this.postId});

  @override
  List<Object?> get props => [];
}

class LikeCommentEvent extends TiktokEvent {
  final String commentId;
  final String postId;
  const LikeCommentEvent({required this.commentId, required this.postId});

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
