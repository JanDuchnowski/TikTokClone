import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:tiktok_clone/models/user/user.dart';
import 'package:tiktok_clone/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryInterface _profileRepository;
  ProfileBloc(this._profileRepository) : super(ProfileState.initial()) {
    on<FetchProfileEvent>((event, emit) async {
      final Stream<QuerySnapshot<Map<String, dynamic>>>? profileInfoStream =
          _profileRepository.getProfileInfoStream(event.uid);

      final Stream<QuerySnapshot<Map<String, dynamic>>>? postsStream =
          _profileRepository.fetchUserPosts(event.uid);

      emit.forEach(
        postsStream!,
        onData: ((QuerySnapshot<Map<String, dynamic>>? data) {
          return state.copyWith(
              profilePosts: data, profileStatus: ProfileStatus.fetched);
        }),
      );
      await emit.forEach(
        profileInfoStream!,
        onData: ((QuerySnapshot<Map<String, dynamic>> data) {
          return state.copyWith(
            profileInfoQuery: data,
            userId: event.uid,
          );
        }),
      );
    });
    on<FollowUserEvent>(
      //TODO this could be in repository
      (event, emit) {
        _profileRepository.followUser(event.otherUserId);
        emit(state.copyWith());
      },
    );
    on<FetchFollowersEvent>(
      (event, emit) async {
        final followersToString =
            event.profileUser.followers.map((e) => e.toString()).toList();

        final List<User>? followersList =
            await _profileRepository.fetchFollowers(followersToString);

        print("followers list  ${followersList}");

        if (followersList != null) {
          emit(state.copyWith(followersList: followersList));
        }
      },
    );
    on<FetchFollowingEvent>(
      (event, emit) async {
        final followingToString =
            event.profileUser.following.map((e) => e.toString()).toList();
        final List<User>?
            followingList = //TODO if this stream is null it means that following/followers are empty NEED TO HANDLE THAT CASE
            await _profileRepository.fetchFollowing(followingToString);
        print("following list  ${followingList}");
        if (followingList != null) {
          emit(state.copyWith(
            followingList: followingList,
          ));
        } else {
          //TODO when going first to a person with not null followers (not empty), and then going to person with no followers, the state is not updated because it is null. Maybe emit a decoy state ?
          print("Stream is null");
          emit(state.copyWith(followingList: null));
        }
      },
    );
  }
}
