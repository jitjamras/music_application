import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/model/music_model.dart';

class MusicController {
  //fetch Data from list_song.json
  List<Music> musicList = [];
  Music? currentMusic;
  final player = AudioPlayer();
  bool isPause = false;

  Future loadMusic() async {
    final response =
        await jsonDecode(await rootBundle.loadString('assets/list_song.json'));
    // debugPrint('JSON Decode : $response');

    musicList = (response as List<dynamic>?)
            ?.map((e) => Music.fromMap(e as Map<String, dynamic>))
            .toList() ??
        [];

    // debugPrint(musicList.toString());
  }

  Future playMusic(Music music) async {
    try {
      await player.setUrl(music.url);
      await player.play();
    } on FormatException catch (e) {
      debugPrint('Format error: ${e.message}');
    } on Exception catch (e) {
      debugPrint('An error occurred: ${e.toString()}');
    }
  }

  Future pauseMusic() async {
    try {
      isPause = !isPause;
      if (isPause) {
        await player.pause();
      } else {
        await player.play();
      }
    } catch (e) {
      debugPrint('Error pausing music: ${e.toString()}');
    }
  }

  Future stopMusic() async {
    try {
      await player.stop();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future seekMusic(Duration position) async {
    try {
      await player.seek(position);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future replayMusic() async {
    try {
      await player.seek(Duration.zero);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> selectMusic(int index) async {
    if (index < 0 || index >= musicList.length) {
      debugPrint('Invalid music index: $index');
      return;
    }
    currentMusic = musicList[index];
    await playMusic(currentMusic!);
  }

  Future<void> previousMusic() async {
    int index = musicList.indexWhere(
      (Music element) => element == currentMusic,
    );
    if (index == -1) return;
    currentMusic = musicList[(index - 1 + musicList.length) % musicList.length];
    await playMusic(currentMusic!);
  }

  Future<void> forwardMusic() async {
    int index = musicList.indexWhere(
      (Music element) => element == currentMusic,
    );
    if (index == -1) return; // Current music not found
    currentMusic = musicList[(index + 1) % musicList.length];
    await playMusic(currentMusic!);
  }
}
