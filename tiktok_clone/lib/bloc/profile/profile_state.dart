part of 'profile_bloc.dart';

enum ProfileStatus { initial, fetched }

@immutable
class ProfileState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? profileInfoQuery;
  final QuerySnapshot<Map<String, dynamic>>? profilePosts;
  final String? userId;
  final ProfileStatus? profileStatus;
  final QuerySnapshot<Map<String, dynamic>>? followersQuery;
  final QuerySnapshot<Map<String, dynamic>>? followingQuery;
  const ProfileState(
      {this.profileInfoQuery,
      this.userId,
      this.profilePosts,
      this.profileStatus,
      this.followersQuery,
      this.followingQuery});

  ProfileState.initial()
      : profileInfoQuery = null,
        userId = "",
        profilePosts = null,
        profileStatus = ProfileStatus.initial,
        followersQuery = null,
        followingQuery = null;

  ProfileState copyWith(
      {QuerySnapshot<Map<String, dynamic>>? profileInfoQuery,
      String? userId,
      QuerySnapshot<Map<String, dynamic>>? profilePosts,
      ProfileStatus? profileStatus,
      QuerySnapshot<Map<String, dynamic>>? followingQuery,
      QuerySnapshot<Map<String, dynamic>>? followersQuery}) {
    return ProfileState(
      profileInfoQuery: profileInfoQuery ?? this.profileInfoQuery,
      userId: userId ?? this.userId,
      profilePosts: profilePosts ?? this.profilePosts,
      profileStatus: profileStatus ?? this.profileStatus,
      followingQuery: followingQuery ?? this.followingQuery,
      followersQuery: followersQuery ?? this.followersQuery,
    );
  }

  @override
  List<Object?> get props => [
        profileInfoQuery,
        profilePosts,
        userId,
        profileStatus,
        followersQuery,
        followingQuery
      ];
}

class ProfileFetched extends ProfileState {}
