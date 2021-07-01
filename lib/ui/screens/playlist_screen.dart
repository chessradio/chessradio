import 'package:chessradio/bloc/PuzzlesBloc.dart';
import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/repository/PuzzleRepository.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_drawer_widget.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_title_widget.dart';
import 'package:chessradio/ui/widgets/playlist/audio_bar_widget.dart';
import 'package:chessradio/ui/widgets/playlist/control_buttons_widget.dart';
import 'package:chessradio/ui/widgets/playlist/playlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';

class PlayListScreen extends StatefulWidget {
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  late PuzzleRepository _repository;
  late AudioPlayer _player;
  late List<Puzzle> _playlist;

  @override
  void initState() {
    super.initState();
    _repository = PuzzleRepository();
    _player = AudioPlayer();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    _playlist =
        await _repository.fetchPuzzles().then((value) => value.toList());

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setAudioSource(ConcatenatingAudioSource(
          children: _playlist
              .map((puzzle) =>
                  AudioSource.uri(Uri.parse(puzzle.audioAsset), tag: puzzle))
              .toList()));
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
                    PlaylistWidget(_player, PuzzlesBloc()),
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
