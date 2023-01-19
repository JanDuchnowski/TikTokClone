part of 'tiktok_bloc.dart';

abstract class TiktokEvent extends Equatable {
  const TiktokEvent();
}

class FetchPostsEvent extends TiktokEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
