part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final QuerySnapshot<Map<String, dynamic>>? profileInfoQuery;
  final String? userId;
  const ProfileState({this.profileInfoQuery, this.userId});

  const ProfileState.initial()
      : profileInfoQuery = null,
        userId = "";

  ProfileState copyWith(
      {QuerySnapshot<Map<String, dynamic>>? profileInfoQuery, String? userId}) {
    return ProfileState(
        profileInfoQuery: profileInfoQuery ?? this.profileInfoQuery,
        userId: userId ?? this.userId);
  }

  @override
  List<Object?> get props => [profileInfoQuery, userId];
}
