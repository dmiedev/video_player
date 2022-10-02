import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required String videoLink,
  }) : super(PlayerState(videoLink: videoLink)) {
    on<PlayerEvent>((event, emit) {});
  }
}
