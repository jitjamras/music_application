import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_application/components/progressbar.dart';
import 'package:music_application/controller/music_controller.dart';

class MinibarMusic extends StatelessWidget {
  final MusicController musicController;
  final void Function(Duration) onSeekMusic;
  final void Function() onPause;
  const MinibarMusic(
      {super.key,
      required this.musicController,
      required this.onSeekMusic,
      required this.onPause});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: height * 0.15,
        alignment: Alignment.center,
        child: Column(
          children: [
            ProgressbarComponent(
              musicController: musicController,
              onSeekMusic: onSeekMusic,
              timeLabelLocation: TimeLabelLocation.none,
            ),
            ListTile(
              leading: Image.network(musicController.currentMusic!.artwork),
              title: Text(
                musicController.currentMusic!.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(musicController.currentMusic!.artist),
              trailing: GestureDetector(
                onTap: onPause,
                child: musicController.isPause
                    ? const Icon(
                        Icons.play_circle_outline_rounded,
                        size: 40,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.pause_circle_outline_rounded,
                        size: 40,
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ));
  }
}
