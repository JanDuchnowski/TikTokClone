part of 'tiktok_bloc.dart';

enum AppStatus { initial, postsFetched }

@immutable
class TiktokState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? postsQuery;
  final List<String>? likedPosts;
  final AppStatus? status;
  TiktokState({this.postsQuery, this.likedPosts, this.status});
  TiktokState.initial()
      : postsQuery = null,
        likedPosts = <String>[],
        status = AppStatus.initial;

  TiktokState copyWith({
    QuerySnapshot<Map<String, dynamic>>? postsQuery,
    List<String>? likedPosts,
    AppStatus? status,
  }) {
    return TiktokState(
      postsQuery: postsQuery ?? this.postsQuery,
      likedPosts: likedPosts ?? this.likedPosts,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [postsQuery, likedPosts];
}

// class TiktokInitial extends TiktokState {
//   const TiktokInitial();
// }

// class TikTokFetchedPosts extends TiktokState {
//   final QuerySnapshot<Map<String, dynamic>>? postsQuery;
//   final List<String>? likedPosts;
//   const TikTokFetchedPosts(
//       {required this.postsQuery, required this.likedPosts});

//   TikTokFetchedPosts copyWith(QuerySnapshot<Map<String, dynamic>>? postsQuery,
//       List<String>? likedPosts) {
//     return TikTokFetchedPosts(
//         postsQuery: postsQuery ?? this.postsQuery,
//         likedPosts: likedPosts ?? this.likedPosts);
//   }

