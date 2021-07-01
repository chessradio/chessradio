import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/Response.dart';
import 'package:chessradio/repository/PuzzlesRepository.dart';

class PuzzlesBloc {
  late PuzzlessRepository _puzzleRepository;
  late StreamController<Response<List<Puzzle>>> _puzzleListController;

  StreamSink<Response<List<Puzzle>>> get puzzlesListSink =>
      _puzzleListController.sink;

  Stream<Response<List<Puzzle>>> get puzzlesListStream =>
      _puzzleListController.stream;

  PuzzlesBloc() {
    _puzzleRepository = PuzzlessRepository();
    _puzzleListController = StreamController<Response<List<Puzzle>>>();
    fetchPuzzles();
  }

  fetchPuzzles() async {
    puzzlesListSink.add(Response.loading('Getting Puzzles...'));
    try {
      List<Puzzle> puzzles = await _puzzleRepository.fetchPuzzles();
      puzzlesListSink.add(Response.completed(puzzles));
    } catch (e) {
      puzzlesListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _puzzleListController.close();
  }
}
