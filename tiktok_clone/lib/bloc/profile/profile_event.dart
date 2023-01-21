part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class FetchProfileEvent extends ProfileEvent {
  final String uid;
  FetchProfileEvent({required this.uid});
  @override
  List<Object?> get props => [];
}
