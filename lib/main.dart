import 'package:chessradio/ui/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ChessRadio());
}

class ChessRadio extends StatefulWidget {
  @override
  _ChessRadioState createState() => _ChessRadioState();
}

class _ChessRadioState extends State<ChessRadio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.niconneTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreenView(
        navigateRoute: PlayListScreen(),
        duration: 5000,
        text: "Chess Radio",
        textStyle: TextStyle(
          fontSize: 60.0,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
