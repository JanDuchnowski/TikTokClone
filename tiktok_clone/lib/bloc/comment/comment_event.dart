part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent extends Equatable {}

class FetchCommentsEvent extends CommentEvent {
  final String postId;

  FetchCommentsEvent({required this.postId});
  @override
  List<Object?> get props => [];
}

class PostCommentEvent extends CommentEvent {
  final String commentText;
  final String postId;
  PostCommentEvent({required this.commentText, required this.postId});

  @override
  List<Object?> get props => [];
}

class LikeCommentEvent extends CommentEvent {
  final String commentId;
  final String postId;
  LikeCommentEvent({required this.commentId, required this.postId});

  @override
  List<Object?> get props => [];
}
