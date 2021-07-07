import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/repository/PuzzleRepository.dart';
import 'package:chessradio/ui/widgets/playlist/puzzle_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistWidget extends StatefulWidget {
  final AudioPlayer player;
  PlaylistWidget(this.player);

  @override
  _PlaylistWidgetState createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  late List<Puzzle> _playlist;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    PuzzleRepository repository = PuzzleRepository();
    _playlist = await repository.fetchPuzzles().then((value) => value.toList());
    try {
      await widget.player.setAudioSource(ConcatenatingAudioSource(
          children: _playlist
              .map((puzzle) =>
                  AudioSource.uri(Uri.parse(puzzle.audio), tag: puzzle))
              .toList()));
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: StreamBuilder<SequenceState?>(
        stream: widget.player.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          final sequence = state?.sequence ?? [];
          return ListView.builder(
              itemCount: sequence.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    PuzzleWidget(
                        sequence[index].tag,
                        index == state!.currentIndex
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        () => widget.player.seek(Duration.zero, index: index)),
                    Divider(
                      color: Colors.black,
                      height: 0,
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const Error(this.errorMessage, this.onRetryPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed(),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
    );
  }
}
