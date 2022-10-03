part of 'chrome_cast_bloc.dart';

enum ChromeCastStatus { idle, playing, paused }

class ChromeCastState extends Equatable {
  const ChromeCastState({
    this.controller,
    this.status = ChromeCastStatus.idle,
  });

  final ChromeCastController? controller;
  final ChromeCastStatus status;

  ChromeCastState copyWith({
    ChromeCastController? Function()? controller,
    ChromeCastStatus? status,
  }) {
    return ChromeCastState(
      controller: controller != null ? controller() : this.controller,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [controller, status];
}
