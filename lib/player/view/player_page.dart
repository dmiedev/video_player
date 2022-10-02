import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/player/bloc/player_bloc.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    super.key,
    required this.videoLink,
  });

  final String videoLink;

  static MaterialPageRoute<PlayerPage> getRoute({required String videoLink}) {
    return MaterialPageRoute(
      builder: (context) => PlayerPage(
        videoLink: videoLink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(videoLink: videoLink),
      child: const _PlayerView(),
    );
  }
}

class _PlayerView extends StatefulWidget {
  const _PlayerView();

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView> {
  late final VideoPlayerController _playerController;
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    final state = context.read<PlayerBloc>().state;
    _playerController = VideoPlayerController.network(state.videoLink);
    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      autoInitialize: true,
      autoPlay: true,
      showOptions: false,
      allowMuting: false,
      customControls: const MaterialControls(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00282828),
      appBar: AppBar(
        title: const Text('Video Playback'),
      ),
      body: Chewie(controller: _chewieController),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _playerController.dispose();
    super.dispose();
  }
}
