import 'package:chessradio/ui/screens/about_screen.dart';
import 'package:chessradio/ui/screens/feedback_screen.dart';
import 'package:chessradio/ui/screens/gettheapp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
          if (kIsWeb)
            PopupMenuItem(
              child: ElevatedButton(
                child: Center(
                  child: Text(
                    'Get the app',
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
                      builder: (context) => GetTheAppScreen(),
                    ),
                  );
                },
              ),
            ),
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
