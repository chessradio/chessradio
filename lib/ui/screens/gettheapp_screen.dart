import 'package:chessradio/bloc/puzzles_bloc.dart';
import 'package:chessradio/ui/screens/playlist_screen.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_drawer_widget.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class GetTheAppScreen extends StatefulWidget {
  @override
  _GetTheAppScreenState createState() => _GetTheAppScreenState();
}

class _GetTheAppScreenState extends State<GetTheAppScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get the app',
      home: Scaffold(
        appBar: AppBar(
          title: ChessRadioTitleWidget('Get the app', false),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayListScreen(new PuzzlesBloc()),
                ),
              );
            },
          ),
          actions: [
            ChessRadioDrawerWidget(),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: (Text(
                '''Get the app and listen to Chess Radio on your smartphone.
 ''',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              )),
              margin: const EdgeInsets.all(50),
            ),
            GestureDetector(
              onTap: _launchURLAndroid,
              child: Image.asset(
                'assets/images/playstore.png',
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class SelectorScreen {}

_launchURLAndroid() async {
  const url = 'https://play.google.com/store/search?q=chessradio';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
