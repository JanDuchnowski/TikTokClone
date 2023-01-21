part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? profileInfoQuery;

  const ProfileState({this.profileInfoQuery});

  ProfileState.initial() : profileInfoQuery = null;

  ProfileState copyWith(
      {QuerySnapshot<Map<String, dynamic>>? profileInfoQuery}) {
    return ProfileState(
        profileInfoQuery: profileInfoQuery ?? this.profileInfoQuery);
  }

  @override
  List<Object?> get props => [profileInfoQuery];
}
