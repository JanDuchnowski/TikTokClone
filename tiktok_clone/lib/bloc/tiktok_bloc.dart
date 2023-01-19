import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiktok_clone/repository/post_repository.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final PostRepositoryInterface _postRepository;
  TiktokBloc(this._postRepository) : super(TiktokInitial()) {
    on<TiktokEvent>((event, emit) async {
      if (event is FetchPostsEvent) {
        final Stream<QuerySnapshot<Map<String, dynamic>>> postStream =
            _postRepository.getPostStream();

        await emit.forEach(postStream,
            onData: ((QuerySnapshot<Map<String, dynamic>> data) {
          print(data);
          return TikTokFetchedPosts(postsQuery: data);
        }));
      } else if (event is LikePostEvent) {
        _postRepository.likePost(event.postId);
        emit(state);
      }
    });
  }
}
