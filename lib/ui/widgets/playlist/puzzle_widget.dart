import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/ui/widgets/playlist/image_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        onTap: widget.onTap,
        leading: Wrap(
          children: [
            Tooltip(
                preferBelow: false,
                height: 30,
                message: "Moves " +
                    widget.puzzle.player
                        .toString()
                        .split('.')
                        .last
                        .toLowerCase(),
                child: IconButton(
                    onPressed: null,
                    icon: widget.puzzle.player == Player.WHITE
                        ? new Image.asset("assets/icons/white-piece.png")
                        : new Image.asset("assets/icons/black-piece.png"))),
            Tooltip(
              preferBelow: false,
              message: 'Mate in 1',
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black, // Set border color
                      width: 1.0), // Set border width
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ), //
                child: Text(
                  'M1',
                  style: GoogleFonts.rochester(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Tooltip(
              preferBelow: false,
              message: 'The puzzle has ${widget.puzzle.pieces} pieces',
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black, // Set border color
                      width: 1.0), // Set border width
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ), //
                child: Text(
                  "${widget.puzzle.pieces} pieces",
                  style: GoogleFonts.rochester(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: Tooltip(
          preferBelow: false,
          message: "Show solution",
          child: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              size: 30,
              color: Colors.grey[700],
            ),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (_) => ImageDialog(widget.puzzle.image));
            },
          ),
        ),
      ),
    );
  }
}
