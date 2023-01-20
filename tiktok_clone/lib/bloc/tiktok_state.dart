part of 'tiktok_bloc.dart';

enum AppStatus { initial, postsFetched, commentsFetched }

@immutable
class TiktokState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? postsQuery;
  final List<String>? likedPosts;
  final AppStatus? status;
  final QuerySnapshot<Map<String, dynamic>>? commentQuery;

  TiktokState(
      {this.postsQuery, this.likedPosts, this.status, this.commentQuery});
  TiktokState.initial()
      : postsQuery = null,
        likedPosts = <String>[],
        status = AppStatus.initial,
        commentQuery = null;

  TiktokState copyWith({
    QuerySnapshot<Map<String, dynamic>>? postsQuery,
    List<String>? likedPosts,
    AppStatus? status,
    QuerySnapshot<Map<String, dynamic>>? commentQuery,
  }) {
    return TiktokState(
      postsQuery: postsQuery ?? this.postsQuery,
      likedPosts: likedPosts ?? this.likedPosts,
      status: status ?? this.status,
      commentQuery: commentQuery ?? this.commentQuery,
    );
  }

  @override
  List<Object?> get props => [postsQuery, likedPosts, status, commentQuery];
}
