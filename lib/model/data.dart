import 'package:just_audio/just_audio.dart';
import 'package:chessradio/model/metadata.dart';

final ConcatenatingAudioSource playlist = ConcatenatingAudioSource(children: [
  ClippingAudioSource(
    start: Duration(seconds: 60),
    end: Duration(seconds: 90),
    child: AudioSource.uri(Uri.parse(
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
    tag: AudioMetadata(
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science (30 seconds)",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
  AudioSource.uri(
    Uri.parse(
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
    tag: AudioMetadata(
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
  AudioSource.uri(
    Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
    tag: AudioMetadata(
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
  AudioSource.uri(
    Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
    tag: AudioMetadata(
      album: "Science Friday 2",
      title: "From Cat Rheology To Operatic Incompetence 2",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
]);
