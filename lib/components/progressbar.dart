import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../controller/music_controller.dart';

class ProgressbarComponent extends StatelessWidget {
  final MusicController musicController;
  final void Function(Duration) onSeekMusic;
  final TimeLabelLocation timeLabelLocation;
  const ProgressbarComponent(
      {super.key,
      required this.musicController,
      required this.onSeekMusic,
      required this.timeLabelLocation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
        stream: musicController.player.positionStream,
        builder: (context, snapshot) {
          return ProgressBar(
              progress: snapshot.data ?? Duration.zero,
              total: musicController.player.duration ?? Duration.zero,
              buffered: snapshot.data,
              barHeight: 4,
              thumbCanPaintOutsideBar: false,
              barCapShape: BarCapShape.square,
              thumbRadius: 0,
              thumbGlowRadius: 0,
              timeLabelLocation: timeLabelLocation,
              timeLabelType: TimeLabelType.remainingTime,
              onSeek: onSeekMusic);
        });
  }
}
