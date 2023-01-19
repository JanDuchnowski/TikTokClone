part of 'tiktok_bloc.dart';

@immutable
abstract class TiktokState {
  const TiktokState();
}

class TiktokInitial extends TiktokState {
  const TiktokInitial();
}

class TikTokFetchedPosts extends TiktokState {
  final QuerySnapshot<Map<String, dynamic>> postsQuery;

  const TikTokFetchedPosts({required this.postsQuery});
}
