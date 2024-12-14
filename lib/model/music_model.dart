import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Music {
  int id;
  String title;
  String artist;
  String artwork;
  String url;
  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.artwork,
    required this.url,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'artist': artist,
      'artwork': artwork,
      'url': url,
    };
  }

  factory Music.fromMap(Map<String, dynamic> map) {
    return Music(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      artist: map['artist'] as String,
      artwork: map['artwork'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Music.fromJson(String source) => Music.fromMap(json.decode(source) as Map<String, dynamic>);
}
