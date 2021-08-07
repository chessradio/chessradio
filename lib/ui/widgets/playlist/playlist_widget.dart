import 'package:chessradio/bloc/puzzles_bloc.dart';
import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/response.dart';
import 'package:chessradio/ui/widgets/playlist/puzzle_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistWidget extends StatefulWidget {
  final AudioPlayer player;
  final PuzzlesBloc bloc;
  PlaylistWidget(this.player, this.bloc);

  @override
  _PlaylistWidgetState createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void select(Puzzle puzzle) async {
    widget.player.seek(Duration.zero, index: 0);
    try {
      await widget.player.setAudioSource(
        AudioSource.uri(Uri.parse(puzzle.audio), tag: puzzle),
      );
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.bloc.fetchPuzzles(),
      child: StreamBuilder<Response<List<Puzzle>>>(
        stream: widget.bloc.ebookListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return Loading();
              case Status.COMPLETED:
                select(snapshot.data!.data[_current]);
                return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          PuzzleWidget(
                            snapshot.data!.data[index],
                            _current == index
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            () {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          Divider(
                            color: Colors.black,
                            height: 0,
                          )
                        ],
                      );
                    });
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data!.message,
                  onRetryPressed: () => widget.bloc.fetchPuzzles(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const Error({required this.errorMessage, required this.onRetryPressed});

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
