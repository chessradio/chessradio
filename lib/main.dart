import 'package:chessradio/ui/screens/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

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
      title: 'Welcome to chess radio',
      home: SplashScreenView(
        navigateRoute: PlayListScreen(),
        duration: 5000,
        imageSize: 130,
        imageSrc: "assets/icons/black-piece.png",
        text: "Welcome to chess radio!",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40.0,
        ),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
