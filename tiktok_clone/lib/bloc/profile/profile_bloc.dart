import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiktok_clone/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryInterface _profileRepository;
  ProfileBloc(this._profileRepository) : super(ProfileState.initial()) {
    on<FetchProfileEvent>((event, emit) async {
      final Stream<QuerySnapshot<Map<String, dynamic>>>? postInfoStream =
          _profileRepository.getProfileInfoStream(event.uid);

      await emit.forEach(
        postInfoStream!,
        onData: ((QuerySnapshot<Map<String, dynamic>> data) {
          return state.copyWith(profileInfoQuery: data);
        }),
      );
    });
  }
}
