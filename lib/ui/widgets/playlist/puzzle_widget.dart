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
        leading: Wrap(
          children: [
            Tooltip(
                message: widget.puzzle.playingAs.toString().split('.').last +
                    " pieces start",
                child: IconButton(
                    onPressed: null,
                    icon: widget.puzzle.playingAs == PieceColor.WHITE
                        ? new Image.asset("assets/icons/white-piece.png")
                        : new Image.asset("assets/icons/black-piece.png"))),
            Tooltip(
                message:
                    widget.puzzle.level.toString().split('.').last + " level",
                child: IconButton(
                    onPressed: null,
                    icon: widget.puzzle.level == Level.EASY
                        ? new Image.asset("assets/icons/easy.png")
                        : widget.puzzle.level == Level.MEDIUM
                            ? new Image.asset("assets/icons/medium.png")
                            : new Image.asset("assets/icons/hard.png")))
          ],
        ),
        trailing: Tooltip(
          message: "Show solution",
          child: IconButton(
            icon: Icon(Icons.remove_red_eye, size: 30),
            onPressed: () async {
              print('show solution!');
            },
          ),
        ),
      ),
    );
  }
}
