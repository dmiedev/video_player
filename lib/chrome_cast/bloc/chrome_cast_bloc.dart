import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cast_video/flutter_cast_video.dart';

part 'chrome_cast_event.dart';
part 'chrome_cast_state.dart';

class ChromeCastBloc extends Bloc<ChromeCastEvent, ChromeCastState> {
  ChromeCastBloc() : super(const ChromeCastState()) {
    on<ChromeCastInitialized>(_handleInitialized);
    on<ChromeCastStarted>(_handleStarted);
    on<ChromeCastPlaybackToggled>(_handlePlaybackToggled);
    on<ChromeCastReplayed>(_handleReplayed);
    on<ChromeCastForwarded>(_handleForwarded);
    on<ChromeCastEnded>(_handleEnded);
  }

  Future<void> _handleInitialized(
    ChromeCastInitialized event,
    Emitter<ChromeCastState> emit,
  ) async {
    emit(ChromeCastState(controller: event.controller));
    await state.controller!.addSessionListener();
  }

  Future<void> _handleStarted(
    ChromeCastStarted event,
    Emitter<ChromeCastState> emit,
  ) async {
    if (state.controller == null) {
      return;
    }
    await state.controller!.loadMedia(event.videoLink);
    await state.controller!.play();
    emit(state.copyWith(status: ChromeCastStatus.playing));
  }

  Future<void> _handlePlaybackToggled(
    ChromeCastPlaybackToggled event,
    Emitter<ChromeCastState> emit,
  ) async {
    if (state.controller == null) {
      return;
    }
    if (state.status == ChromeCastStatus.playing) {
      await state.controller!.pause();
      emit(state.copyWith(status: ChromeCastStatus.paused));
    } else {
      await state.controller!.play();
      emit(state.copyWith(status: ChromeCastStatus.playing));
    }
  }

  Future<void> _handleReplayed(
    ChromeCastReplayed event,
    Emitter<ChromeCastState> emit,
  ) async {
    if (state.controller == null) {
      return;
    }
    await state.controller!.seek(
      relative: true,
      interval: -event.seconds.toDouble(),
    );
  }

  Future<void> _handleForwarded(
    ChromeCastForwarded event,
    Emitter<ChromeCastState> emit,
  ) async {
    if (state.controller == null) {
      return;
    }
    await state.controller!.seek(
      relative: true,
      interval: event.seconds.toDouble(),
    );
  }

  Future<void> _handleEnded(
    ChromeCastEnded event,
    Emitter<ChromeCastState> emit,
  ) async {
    if (state.controller == null) {
      return;
    }
    await state.controller!.stop();
    emit(state.copyWith(status: ChromeCastStatus.idle));
  }
}
