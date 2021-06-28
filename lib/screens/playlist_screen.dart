import 'package:chessradio/widgets/bar/chess_radio_drawer_widget.dart';
import 'package:chessradio/widgets/bar/chess_radio_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';
import 'package:chessradio/data.dart';
import 'package:chessradio/widgets/playlist/audio_bar_widget.dart';
import 'package:chessradio/widgets/playlist/control_buttons_widget.dart';
import 'package:chessradio/widgets/playlist/playlist_widget.dart';

class PlayListScreen extends StatefulWidget {
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  late AudioPlayer _player;
  late ConcatenatingAudioSource _playlist;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _playlist = ConcatenatingAudioSource(
        children: puzzles
            .map((puzzle) =>
                AudioSource.uri(Uri.parse(puzzle.audioPuzzle), tag: puzzle))
            .toList());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Hero(
        tag: 'playlist',
        child: Scaffold(
          appBar: AppBar(
            title: ChessRadioTitleWidget('Train', false),
            backgroundColor: Colors.yellow,
            actions: [
              ChessRadioDrawerWidget(),
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlaylistWidget(_player, _playlist),
                    SizedBox(height: 8.0),
                    AudioBarWidget(_player),
                    ControlButtonsWidget(_player),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
