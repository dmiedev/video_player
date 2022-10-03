import 'package:flutter/material.dart';

class CastControls extends StatelessWidget {
  const CastControls({
    super.key,
    this.paused = false,
    this.color,
    this.onPlayPauseButtonPressed,
    this.onReplay10ButtonPressed,
    this.onForward10ButtonPressed,
  });

  final bool paused;
  final Color? color;
  final VoidCallback? onPlayPauseButtonPressed;
  final VoidCallback? onReplay10ButtonPressed;
  final VoidCallback? onForward10ButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10),
          onPressed: onReplay10ButtonPressed,
          iconSize: 40,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: Icon(paused ? Icons.play_arrow : Icons.pause),
            onPressed: onPlayPauseButtonPressed,
            iconSize: 56,
            color: color,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          onPressed: onForward10ButtonPressed,
          iconSize: 40,
          color: color,
        ),
      ],
    );
  }
}
