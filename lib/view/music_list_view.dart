import 'package:flutter/material.dart';
import 'package:music_application/components/minibar_music.dart';
import 'package:music_application/controller/music_controller.dart';
import 'package:music_application/view/music_detail_view.dart';
import 'package:page_transition/page_transition.dart';

class MusicListView extends StatefulWidget {
  const MusicListView({super.key});

  @override
  State<MusicListView> createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicListView> {
  final MusicController musicController = MusicController();

  Future<void>? fetchPlaylist;

  double sliderValue = 30;

  @override
  void initState() {
    fetchPlaylist = musicController.loadMusic();
    super.initState();
  }

  @override
  void dispose() {
    musicController.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16),
              child: Text(
                'MyPlaylist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchPlaylist,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: musicController.musicList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                              musicController.musicList[index].artwork),
                          title: Text(
                            musicController.musicList[index].title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(musicController.musicList[index].artist),
                          trailing: GestureDetector(
                            onTap: () async {
                              if (musicController.musicList[index] ==
                                  musicController.currentMusic) {
                                // debugPrint('Replay Music');
                                setState(() {
                                  //* Replay Music
                                  musicController.replayMusic();
                                });
                                return;
                              } else {
                                // debugPrint('Select New Music');
                                setState(() {
                                  musicController.selectMusic(index);
                                });
                                return;
                              }
                            },
                            child: musicController.musicList[index] ==
                                    musicController.currentMusic
                                ? const Icon(
                                    Icons.replay,
                                    size: 40,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.play_circle_outline_rounded,
                                    size: 40,
                                    color: Colors.grey[500],
                                  ),
                          ),
                          selected: true,
                          selectedColor: musicController.musicList[index] ==
                                  musicController.currentMusic
                              ? Colors.black
                              : Colors.grey[600],
                        );
                      },
                    );
                  }
                  return Text(snapshot.error.toString());
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: musicController.currentMusic != null
            ? GestureDetector(
                onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            child: MusicDetailView(
                              musicController: musicController,
                            ),
                            type: PageTransitionType.bottomToTop))
                    .then(
                  (_) => setState(() {}),
                ),
                child: MinibarMusic(
                    musicController: musicController,
                    onSeekMusic: (value) {
                      setState(() {
                        musicController.seekMusic(value);
                      });
                    },
                    onPause: () async {
                      if (musicController.isPause) {
                        setState(() {
                          musicController.resumeMusic();
                        });
                      } else {
                        setState(() {
                          musicController.pauseMusic();
                        });
                      }
                    }),
              )
            : null,
      ),
    );
  }
}
