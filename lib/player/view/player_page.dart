import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/player/bloc/player_bloc.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    super.key,
    required this.videoLink,
  });

  static MaterialPageRoute<PlayerPage> getRoute({required String videoLink}) {
    return MaterialPageRoute(
      builder: (context) => PlayerPage(
        videoLink: videoLink,
      ),
    );
  }

  final String videoLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(),
      child: const _PlayerView(),
    );
  }
}

class _PlayerView extends StatelessWidget {
  const _PlayerView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(),
      ),
    );
  }
}
