import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String url;

  ImageDialog(this.url);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
