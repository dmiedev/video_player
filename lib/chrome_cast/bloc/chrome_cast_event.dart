part of 'chrome_cast_bloc.dart';

abstract class ChromeCastEvent extends Equatable {
  const ChromeCastEvent();

  @override
  List<Object> get props => [];
}

class ChromeCastInitialized extends ChromeCastEvent {
  const ChromeCastInitialized({
    required this.controller,
  });

  final ChromeCastController controller;

  @override
  List<Object> get props => [controller];
}

class ChromeCastStarted extends ChromeCastEvent {
  const ChromeCastStarted({required this.videoLink});

  final String videoLink;

  @override
  List<Object> get props => [videoLink];
}

class ChromeCastPlaybackToggled extends ChromeCastEvent {
  const ChromeCastPlaybackToggled();
}

class ChromeCastReplayed extends ChromeCastEvent {
  const ChromeCastReplayed({required this.seconds});

  final int seconds;

  @override
  List<Object> get props => [seconds];
}

class ChromeCastForwarded extends ChromeCastEvent {
  const ChromeCastForwarded({required this.seconds});

  final int seconds;

  @override
  List<Object> get props => [seconds];
}

class ChromeCastEnded extends ChromeCastEvent {
  const ChromeCastEnded();
}
