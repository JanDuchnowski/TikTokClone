part of 'profile_bloc.dart';

enum ProfileStatus { initial, fetched }

@immutable
class ProfileState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? profileInfoQuery;
  final QuerySnapshot<Map<String, dynamic>>? profilePosts;
  final String? userId;
  final ProfileStatus? profileStatus;
  final List<User>? followersList;
  final List<User>? followingList;
  const ProfileState(
      {this.profileInfoQuery,
      this.userId,
      this.profilePosts,
      this.profileStatus,
      this.followersList,
      this.followingList});

  ProfileState.initial()
      : profileInfoQuery = null,
        userId = "",
        profilePosts = null,
        profileStatus = ProfileStatus.initial,
        followersList = [],
        followingList = [];

  ProfileState copyWith(
      {QuerySnapshot<Map<String, dynamic>>? profileInfoQuery,
      String? userId,
      QuerySnapshot<Map<String, dynamic>>? profilePosts,
      ProfileStatus? profileStatus,
      List<User>? followersList,
      List<User>? followingList}) {
    return ProfileState(
      profileInfoQuery: profileInfoQuery ?? this.profileInfoQuery,
      userId: userId ?? this.userId,
      profilePosts: profilePosts ?? this.profilePosts,
      profileStatus: profileStatus ?? this.profileStatus,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
    );
  }

  @override
  List<Object?> get props => [
        profileInfoQuery,
        profilePosts,
        userId,
        profileStatus,
        followersList,
        followingList
      ];
}

class ProfileFetched extends ProfileState {}
