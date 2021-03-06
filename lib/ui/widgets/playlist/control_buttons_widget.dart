import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtonsWidget extends StatelessWidget {
  final AudioPlayer player;

  ControlButtonsWidget(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(color: Colors.transparent),
              );
            } else if (playing != true) {
              return RawMaterialButton(
                onPressed: player.play,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                // elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.play_arrow,
                  size: 40.0,
                ),
                // padding: EdgeInsets.all(15.0),
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              );
            } else if (processingState != ProcessingState.completed) {
              return RawMaterialButton(
                child: Icon(
                  Icons.pause,
                  color: Colors.black,
                  size: 40.0,
                ),
                onPressed: player.pause,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              );
            } else {
              return RawMaterialButton(
                // onPressed: player.play,
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                // elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.play_arrow,
                  size: 40.0,
                ),
                // padding: EdgeInsets.all(15.0),
                shape: CircleBorder(side: BorderSide(color: Colors.black)),

                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
      ],
    );
  }
}
