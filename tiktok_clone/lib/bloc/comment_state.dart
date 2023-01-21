part of 'comment_bloc.dart';

enum CommentStatus { initial, fetched }

@immutable
class CommentState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? commentQuery;
  final CommentStatus? commentStatus;

  const CommentState({this.commentQuery, this.commentStatus});

  const CommentState.initial()
      : commentQuery = null,
        commentStatus = CommentStatus.initial;

  CommentState copyWith({QuerySnapshot<Map<String, dynamic>>? commentQuery}) {
    return CommentState(commentQuery: commentQuery ?? this.commentQuery);
  }

  @override
  List<Object?> get props => [commentQuery, commentStatus];
}
