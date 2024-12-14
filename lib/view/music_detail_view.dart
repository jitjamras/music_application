import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_application/components/progressbar.dart';
import 'package:music_application/controller/music_controller.dart';

class MusicDetailView extends StatefulWidget {
  final MusicController musicController;
  const MusicDetailView({super.key, required this.musicController});

  @override
  State<MusicDetailView> createState() => _MusicDetailViewState();
}

class _MusicDetailViewState extends State<MusicDetailView> {
  late MusicController _musicController;

  @override
  void initState() {
    _musicController = widget.musicController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 36,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          _musicController.currentMusic!.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image Music Artwork
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              width: width * 0.7,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(_musicController.currentMusic!.artwork)),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            title: Text(
              _musicController.currentMusic!.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              _musicController.currentMusic!.artist,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ProgressbarComponent(
              musicController: _musicController,
              onSeekMusic: (value) {
                setState(() {
                  _musicController.seekMusic(value);
                });
              },
              timeLabelLocation: TimeLabelLocation.below,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _musicController.previousMusic();
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 40,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _musicController.pauseMusic();
                  });
                },
                child: _musicController.isPause
                    ? const Icon(
                        Icons.play_circle_outline_rounded,
                        size: 80,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.pause_circle_outline_rounded,
                        size: 80,
                        color: Colors.black,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _musicController.forwardMusic();
                  });
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
