import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/response.dart';
import 'package:chessradio/repository/puzzles_repository.dart';

class PuzzlesBloc {
  final PuzzlesRepository _puzzleRepository = PuzzlesRepository();
  late StreamController<Response<List<Puzzle>>> _puzzleListController;

  StreamSink<Response<List<Puzzle>>> get puzzleListSink =>
      _puzzleListController.sink;

  Stream<Response<List<Puzzle>>> get puzzleListStream =>
      _puzzleListController.stream;

  PuzzlesBloc() {
    _puzzleListController = StreamController<Response<List<Puzzle>>>();
    fetchPuzzles();
  }

  fetchPuzzles() async {
    puzzleListSink.add(Response.loading('Getting puzzles...'));
    try {
      List<Puzzle> puzzles = await _puzzleRepository.fetchPuzzles();
      puzzleListSink.add(Response.completed(puzzles));
    } catch (e) {
      puzzleListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _puzzleListController.close();
  }
}
