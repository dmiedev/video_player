part of 'chrome_cast_bloc.dart';

class ChromeCastState extends Equatable {
  const ChromeCastState({
    this.controller,
    this.isActive = false,
    this.isPlaying = false,
  });

  final ChromeCastController? controller;
  final bool isActive;
  final bool isPlaying;

  ChromeCastState copyWith({
    ChromeCastController? Function()? controller,
    bool? isActive,
    bool? isPlaying,
  }) {
    return ChromeCastState(
      controller: controller != null ? controller() : this.controller,
      isActive: isActive ?? this.isActive,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [controller, isActive, isPlaying];
}
