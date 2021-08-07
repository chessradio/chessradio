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
        // StreamBuilder<SequenceState?>(
        //   stream: player.sequenceStateStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: Icon(
        //       Icons.skip_previous,
        //       color: Colors.black,
        //     ),
        //     onPressed: player.hasPrevious ? player.seekToPrevious : null,
        //   ),
        // ),
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
                child: CircularProgressIndicator(),
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
        // StreamBuilder<SequenceState?>(
        //   stream: player.sequenceStateStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: Icon(
        //       Icons.skip_next,
        //       color: Colors.black,
        //     ),
        //     onPressed: player.hasNext ? player.seekToNext : null,
        //   ),
        // ),
      ],
    );
  }
}

void _showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
