import 'package:chessradio/ui/screens/playlist_screen.dart';
import 'package:flutter/material.dart';

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
