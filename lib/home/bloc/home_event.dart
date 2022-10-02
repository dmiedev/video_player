part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeVideoLinkEntered extends HomeEvent {
  const HomeVideoLinkEntered({required this.videoLink});

  final String videoLink;

  @override
  List<Object?> get props => [videoLink];
}
