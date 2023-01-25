part of 'profile_bloc.dart';

enum ProfileStatus { initial, fetched }

@immutable
class ProfileState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? profileInfoQuery;
  final QuerySnapshot<Map<String, dynamic>>? profilePosts;
  final String? userId;
  final ProfileStatus? profileStatus;
  const ProfileState(
      {this.profileInfoQuery,
      this.userId,
      this.profilePosts,
      this.profileStatus});

  const ProfileState.initial()
      : profileInfoQuery = null,
        userId = "",
        profilePosts = null,
        profileStatus = ProfileStatus.initial;

  ProfileState copyWith(
      {QuerySnapshot<Map<String, dynamic>>? profileInfoQuery,
      String? userId,
      QuerySnapshot<Map<String, dynamic>>? profilePosts,
      ProfileStatus? profileStatus}) {
    return ProfileState(
        profileInfoQuery: profileInfoQuery ?? this.profileInfoQuery,
        userId: userId ?? this.userId,
        profilePosts: profilePosts ?? this.profilePosts,
        profileStatus: profileStatus ?? this.profileStatus);
  }

  @override
  List<Object?> get props =>
      [profileInfoQuery, profilePosts, userId, profileStatus];
}

class ProfileFetched extends ProfileState {}
