import 'package:chessradio/bloc/PuzzlesBloc.dart';
import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/Response.dart';
import 'package:chessradio/ui/widgets/playlist/image_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistWidget extends StatelessWidget {
  final AudioPlayer player;
  final PuzzlesBloc bloc;

  PlaylistWidget(this.player, this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      child: RefreshIndicator(
        onRefresh: () => bloc.fetchPuzzles(),
        child: StreamBuilder<Response<List<Puzzle>>>(
          stream: bloc.puzzlesListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading();
                case Status.COMPLETED:
                  return StreamBuilder<SequenceState?>(
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
                                title:
                                    Text(sequence[index].tag.title as String),
                                onTap: () {
                                  player.seek(Duration.zero, index: index);
                                },
                                leading: Image(
                                  image: sequence[index].tag.playingAs ==
                                          PieceColor.WHITE
                                      ? AssetImage(
                                          "assets/icons/white-piece.png")
                                      : AssetImage(
                                          "assets/icons/black-piece.png"),
                                ),
                              ),
                            );
                          });
                    },
                  );
                case Status.ERROR:
                  return Error(
                      snapshot.data!.message, () => bloc.fetchPuzzles());
              }
            }
            return Container();
          },
        ),
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
