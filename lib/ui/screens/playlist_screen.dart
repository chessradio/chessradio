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
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChessRadio',
      home: Hero(
        tag: 'playlist',
        child: Scaffold(
          appBar: AppBar(
            title: ChessRadioTitleWidget('Chess Radio', true),
            backgroundColor: Colors.black,
            actions: [
              ChessRadioDrawerWidget(),
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
                child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: EdgeInsets.only(
                      bottom: 0,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white, // Set border color
                            width: 1.0), // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(5.0)), // Set rounded corner radius
                        boxShadow: [] // Make rounded corner of border
                        ),
                    child: PlaylistWidget(_player),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 0,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white, // Set border color
                              width: 2.0), // Set border width
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ), // Set rounded corner radius
                          boxShadow: [] // Make rounded corner of border
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AudioBarWidget(_player),
                          ControlButtonsWidget(_player),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Container(
              //   color: Colors.transparent,
              //   height:
              //       screenHeightExcludingToolbar(context, scaleFactor: 0.1),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: AudioBarWidget(_player),
              //   ),
              // ),
              // Container(
              //   color: Colors.transparent,
              //   height:
              //       screenHeightExcludingToolbar(context, scaleFactor: 0.2),
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              //     child: ControlButtonsWidget(_player),
              //   ),
              // )
            ) // ],
                ),
          ),
        ),
      ),
    );
  }

  double screenHeightExcludingToolbar(BuildContext context,
      {double scaleFactor = 1}) {
    return screenHeight(context,
        scaleFactor: scaleFactor, reducedBy: kToolbarHeight);
  }

  double screenHeight(BuildContext context,
      {double scaleFactor = 1, double reducedBy = 0.0}) {
    return (screenSize(context).height - reducedBy) * scaleFactor;
  }

  Size screenSize(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return MediaQuery.of(context).size;
  }
}
