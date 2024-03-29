import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/service/authentication_service.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
import 'package:tiktok_clone/repository/post_repository.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final PostRepositoryInterface _postRepository;
  final AuthenticationRepositoryInterface _authenticationRepository;
  TiktokBloc(this._postRepository, this._authenticationRepository)
      : super(TiktokState.initial()) {
    on<FetchPostsEvent>((event, emit) async {
      final User? currentUser =
          await _authenticationRepository.getCurrentUser();
      final Stream<QuerySnapshot<Map<String, dynamic>>>? postStream =
          _postRepository.getPostStream();
      final List<dynamic> currentLikedPosts =
          await _postRepository.getCurrentlyLikedPosts(currentUser!);
      final List<String> currenStringLikedPosts =
          currentLikedPosts.map((post) => post as String).toList();

      await emit.forEach(postStream!,
          onData: ((QuerySnapshot<Map<String, dynamic>> data) {
        return state.copyWith(
            postsQuery: data,
            status: AppStatus.postsFetched,
            likedPosts: currenStringLikedPosts);
      }));
    });
    on<LikePostEvent>((event, emit) async {
      String? likedPostId = await _postRepository.likePost(event.postId);
      List<dynamic> currentLikedPosts = state.likedPosts!;

      if (currentLikedPosts.contains(likedPostId)) {
        currentLikedPosts.remove(likedPostId);
      } else {
        _postRepository.likePost(likedPostId!);
        currentLikedPosts.add(likedPostId);
      }
      List<String> newLikedPosts =
          currentLikedPosts.map((post) => post as String).toList();

      emit(state.copyWith(
          likedPosts: newLikedPosts, status: AppStatus.postsFetched));
    });

    on<FetchFriendsPostsEvent>(
      (event, emit) async {
        final User? currentUser =
            await _authenticationRepository.getCurrentUser();
        final List<String> friendsList =
            currentUser!.friends.map((friend) => friend.toString()).toList();
        final Stream<QuerySnapshot<Map<String, dynamic>>>? postStream =
            _postRepository.getFriendsPosts(friendsList);
        if (postStream == null) {
          emit(state.copyWith(status: AppStatus.initial));
        } else {
          await emit.forEach(postStream,
              onData: ((QuerySnapshot<Map<String, dynamic>> data) {
            return state.copyWith(
              postsQuery: data,
              status: AppStatus.postsFetched,
            );
          }));
        }
      },
    );
  }
}
