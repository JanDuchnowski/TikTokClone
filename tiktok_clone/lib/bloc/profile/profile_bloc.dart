import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/repository/authentication_repository.dart';
import 'package:tiktok_clone/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryInterface _profileRepository;
  ProfileBloc(this._profileRepository) : super(const ProfileState.initial()) {
    on<FetchProfileEvent>((event, emit) async {
      final Stream<QuerySnapshot<Map<String, dynamic>>>? profileInfoStream =
          _profileRepository.getProfileInfoStream(event.uid);

      final Stream<QuerySnapshot<Map<String, dynamic>>>? postsStream =
          _profileRepository.fetchUserPosts(event.uid);

      emit.forEach(
        postsStream!,
        onData: ((QuerySnapshot<Map<String, dynamic>>? data) {
          print("Fetch videos");
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
              profileStatus: ProfileStatus.fetched);
        }),
      );
    });
    on<FetchProfilePostsEvent>(
      (event, emit) async {},
    );
    on<FollowUserEvent>(
      //TODO this could be in repository
      (event, emit) {
        _profileRepository.followUser(event.otherUserId);
        emit(state.copyWith());
      },
    );
  }
}
