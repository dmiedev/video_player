part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({required this.videoLink});

  final String videoLink;

  @override
  List<Object?> get props => [videoLink];
}
