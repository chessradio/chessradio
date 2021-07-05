import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String asset;

  ImageDialog(this.asset);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(asset),
                fit:
                    BoxFit.fill)), // check CORS if we want to use network image
      ),
    );
  }
}
