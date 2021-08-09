import 'package:chessradio/bloc/puzzles_bloc.dart';
import 'package:chessradio/ui/screens/playlist_screen.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_drawer_widget.dart';
import 'package:chessradio/ui/widgets/bar/chess_radio_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback',
      home: Scaffold(
        appBar: AppBar(
          title: ChessRadioTitleWidget('Feedback', false),
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
        body: Container(
          child: (Text(
            '''Thanks for using our app! 

Found a bug? Comments? Drop us an email at hi@chessrad.io
 ''',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          )),
          margin: const EdgeInsets.all(50),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
