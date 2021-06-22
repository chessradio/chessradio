import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistWidget extends StatelessWidget {
  final AudioPlayer player;
  final ConcatenatingAudioSource playlist;

  PlaylistWidget(this.player, this.playlist);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      child: StreamBuilder<SequenceState?>(
        stream: player.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          final sequence = state?.sequence ?? [];
          return ListView.builder(
              itemCount: sequence.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: index == state!.currentIndex
                      ? Colors.grey.shade300
                      : null,
                  child: ListTile(
                    title: Text(sequence[index].tag.title as String),
                    onTap: () {
                      player.seek(Duration.zero, index: index);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
