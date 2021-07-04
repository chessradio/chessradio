import 'package:chessradio/model/puzzle.dart';
import 'package:flutter/material.dart';

class PuzzleWidget extends StatefulWidget {
  final Puzzle puzzle;
  final Color color;
  final Function() onTap;

  PuzzleWidget(this.puzzle, this.color, this.onTap);

  @override
  _PuzzleWidgetState createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: ListTile(
        title: Text(widget.puzzle.title),
        onTap: widget.onTap,
        leading: Image(
            image: widget.puzzle.playingAs == PieceColor.WHITE
                ? AssetImage("assets/icons/white-piece.png")
                : AssetImage("assets/icons/black-piece.png")),
        trailing: Image(
            image: widget.puzzle.level == Level.EASY
                ? AssetImage("assets/icons/easy.png")
                : widget.puzzle.level == Level.MEDIUM
                    ? AssetImage("assets/icons/medium.png")
                    : AssetImage("assets/icons/hard.png")),
      ),
    );
  }
}
