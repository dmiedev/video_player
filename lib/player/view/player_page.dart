import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cast_video/flutter_cast_video.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/chrome_cast/chrome_cast.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlayerBloc(videoLink: videoLink),
        ),
        BlocProvider(
          create: (context) => ChromeCastBloc(),
        ),
      ],
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
        actions: [
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.all(8),
              child: AirPlayButton(color: Colors.white),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ChromeCastButton(
              color: Colors.white,
              onButtonCreated: _handleCastButtonCreation,
              onSessionStarted: _handleCastSessionStart,
              onSessionEnded: _handleCastSessionEnd,
              onRequestFailed: _handleCastRequestFail,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChromeCastBloc, ChromeCastState>(
        buildWhen: (previous, current) {
          return previous.status != current.status;
        },
        builder: (context, state) {
          if (state.status != ChromeCastStatus.idle) {
            return Center(
              child: CastControls(
                paused: state.status == ChromeCastStatus.paused,
                color: Colors.white,
                onPlayPauseButtonPressed: _handleCastPlayPauseButtonPress,
                onForward10ButtonPressed: _handleCastForwardButtonPress,
                onReplay10ButtonPressed: _handleCastReplayButtonPress,
              ),
            );
          }
          return Chewie(controller: _chewieController);
        },
      ),
    );
  }

  void _handleCastButtonCreation(ChromeCastController controller) {
    context.read<ChromeCastBloc>().add(
          ChromeCastInitialized(controller: controller),
        );
  }

  void _handleCastSessionStart() {
    final playerState = context.read<PlayerBloc>().state;
    context.read<ChromeCastBloc>().add(
          ChromeCastStarted(videoLink: playerState.videoLink),
        );
  }

  void _handleCastPlayPauseButtonPress() {
    context.read<ChromeCastBloc>().add(const ChromeCastPlaybackToggled());
  }

  void _handleCastForwardButtonPress() {
    context.read<ChromeCastBloc>().add(const ChromeCastForwarded(seconds: 10));
  }

  void _handleCastReplayButtonPress() {
    context.read<ChromeCastBloc>().add(const ChromeCastReplayed(seconds: 10));
  }

  void _handleCastRequestFail(String? errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A Chromecast error occurred! ${errorMessage ?? ''}',
        ),
      ),
    );
  }

  void _handleCastSessionEnd() {
    context.read<ChromeCastBloc>().add(const ChromeCastEnded());
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _playerController.dispose();
    super.dispose();
  }
}
