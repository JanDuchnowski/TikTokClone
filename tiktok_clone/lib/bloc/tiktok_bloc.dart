import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/repository/post_repository.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final PostRepository _postRepository = PostRepository();
  TiktokBloc() : super(TiktokInitial()) {
    on<TiktokEvent>((event, emit) {
      if (event is FetchPostsEvent) {
        final Stream<QuerySnapshot<Map<String, dynamic>>> postStream =
            _postRepository.getPostStream();
        postStream.listen(
          (event) => emit(TikTokFetchedPosts(postsStream: event)),
        );
      }
    });
  }
}
