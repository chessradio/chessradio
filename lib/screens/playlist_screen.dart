import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';
import 'package:chessradio/model/data.dart';
import 'package:chessradio/widgets/audio_bar_widget.dart';
import 'package:chessradio/widgets/chess_radio_drawer_widget.dart';
import 'package:chessradio/widgets/chess_radio_title_widget.dart';
import 'package:chessradio/widgets/control_buttons_widget.dart';
import 'package:chessradio/widgets/playlist_widget.dart';

class PlayListScreen extends StatefulWidget {
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  late AudioPlayer _player;
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setAudioSource(playlist);
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
                    PlaylistWidget(_player, playlist),
                    SizedBox(height: 8.0),
                    AudioBarWidget(_player),
                    ControlButtonsWidget(_player, _showSliderDialog),

                    /***                   

                    
                    Row(
                      children: [
                        StreamBuilder<LoopMode>(
                          stream: _player.loopModeStream,
                          builder: (context, snapshot) {
                            final loopMode = snapshot.data ?? LoopMode.off;
                            const icons = [
                              Icon(Icons.repeat, color: Colors.grey),
                              Icon(Icons.repeat, color: Colors.orange),
                              Icon(Icons.repeat_one, color: Colors.orange),
                            ];
                            const cycleModes = [
                              LoopMode.off,
                              LoopMode.all,
                              LoopMode.one,
                            ];
                            final index = cycleModes.indexOf(loopMode);
                            return IconButton(
                              icon: icons[index],
                              onPressed: () {
                                _player.setLoopMode(cycleModes[
                                    (cycleModes.indexOf(loopMode) + 1) %
                                        cycleModes.length]);
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: Text(
                            "Playlist",
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: _player.shuffleModeEnabledStream,
                          builder: (context, snapshot) {
                            final shuffleModeEnabled = snapshot.data ?? false;
                            return IconButton(
                              icon: shuffleModeEnabled
                                  ? Icon(Icons.shuffle, color: Colors.orange)
                                  : Icon(Icons.shuffle, color: Colors.grey),
                              onPressed: () async {
                                final enable = !shuffleModeEnabled;
                                if (enable) {
                                  await _player.shuffle();
                                }
                                await _player.setShuffleModeEnabled(enable);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                   
                   
                
                  
         */
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

void _showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
