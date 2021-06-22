import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ChessRadioTitleWidget extends StatelessWidget {
  final String titleText;
  final bool logo;

  ChessRadioTitleWidget(this.titleText, this.logo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RichText(
          text: TextSpan(
            style: logo
                ? GoogleFonts.dancingScript()
                : GoogleFonts.montserrat(
                    fontWeight: FontWeight.w200,
                  ),
            children: <TextSpan>[
              TextSpan(
                text: titleText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
