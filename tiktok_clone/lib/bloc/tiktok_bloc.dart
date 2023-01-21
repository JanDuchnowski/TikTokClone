import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/models/video/video.dart';
import 'package:tiktok_clone/repository/post_repository.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  final PostRepositoryInterface _postRepository;
  TiktokBloc(this._postRepository) : super(TiktokState.initial()) {
    on<TiktokEvent>(
      (event, emit) async {
        if (event is FetchPostsEvent) {
          final Stream<QuerySnapshot<Map<String, dynamic>>>? postStream =
              _postRepository.getPostStream();
          final List<dynamic> currentLikedPosts =
              await _postRepository.getCurrentlyLikedPosts();
          final List<String> currenStringLikedPosts =
              currentLikedPosts.map((post) => post as String).toList();

          await emit.forEach(postStream!,
              onData: ((QuerySnapshot<Map<String, dynamic>> data) {
            return state.copyWith(
                postsQuery: data,
                status: AppStatus.postsFetched,
                likedPosts: currenStringLikedPosts);
          }));
        } else if (event is LikePostEvent) {
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
        }
        //COMMENT SECTION
        // } else if (event is FetchCommentsEvent) {
        //   final Stream<QuerySnapshot<Map<String, dynamic>>>? commentStream =
        //       _postRepository.getCommentStream(event.postId);
        //   await emit.forEach(commentStream!,
        //       onData: ((QuerySnapshot<Map<String, dynamic>> data) {
        //     return state.copyWith(
        //       commentQuery: data,
        //     );
        //   }));
        // } else if (event is PostCommentEvent) {
        //   _postRepository.postComment(event.commentText, event.postId);
        // } else if (event is LikeCommentEvent) {
        //   _postRepository.likeComment(event.commentId, event.postId);
        // }
        //FRIENDS
        else if (event is FetchFriendsPostsEvent) {
          final User? currentUser = await AuthController().getCurrentUser();
          final List<String> currentFriendsList =
              currentUser!.friends.map((friend) => friend.toString()).toList();
          final Stream<QuerySnapshot<Map<String, dynamic>>>? postStream =
              _postRepository.getFriendsPosts(currentFriendsList);
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
        }
        //PROFILE
        else if (event is FetchProfileEvent) {
          final Stream<QuerySnapshot<Map<String, dynamic>>>? postInfoStream =
              _postRepository.getProfileInfoStream(event.uid);

          await emit.forEach(
            postInfoStream!,
            onData: ((QuerySnapshot<Map<String, dynamic>> data) {
              return state.copyWith(
                postInfoQuery: data,
              );
            }),
          );
        }
      },
    );
  }
}
