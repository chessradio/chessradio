import 'package:chessradio/ui/screens/about_screen.dart';
import 'package:chessradio/ui/screens/feedback_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChessRadioDrawerWidget extends StatefulWidget {
  @override
  _ChessRadioDrawerWidgetState createState() => _ChessRadioDrawerWidgetState();
}

class _ChessRadioDrawerWidgetState extends State<ChessRadioDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<ElevatedButton>(itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ElevatedButton(
              child: Center(
                child: Text(
                  'About',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
            ),
          ),
          PopupMenuItem(
            child: ElevatedButton(
              child: Center(
                child: Text(
                  'Feedback',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeedbackScreen(),
                  ),
                );
              },
            ),
          ),
        ];
      }),
    );
  }
}

// onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => SelectorScreen(),
//                   ),
//                 );
//               },
