import 'package:flutter/material.dart';
import 'package:chessradio/screens/playlist_screen.dart';

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
    return PlayListScreen();
  }
}
