import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tiktok_event.dart';
part 'tiktok_state.dart';

class TiktokBloc extends Bloc<TiktokEvent, TiktokState> {
  TiktokBloc() : super(TiktokInitial()) {
    on<TiktokEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
