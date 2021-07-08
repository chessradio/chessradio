import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/response.dart';
import 'package:chessradio/repository/puzzles_repository.dart';

class PuzzlesBloc {
  final PuzzlesRepository _ebookRepository = PuzzlesRepository();
  late StreamController<Response<List<Puzzle>>> _ebookListController;

  StreamSink<Response<List<Puzzle>>> get ebookListSink =>
      _ebookListController.sink;

  Stream<Response<List<Puzzle>>> get ebookListStream =>
      _ebookListController.stream;

  PuzzlesBloc() {
    _ebookListController = StreamController<Response<List<Puzzle>>>();
    fetchPuzzles();
  }

  fetchPuzzles() async {
    ebookListSink.add(Response.loading('Getting Puzzles...'));
    try {
      List<Puzzle> ebooks = await _ebookRepository.fetchPuzzles();
      ebookListSink.add(Response.completed(ebooks));
    } catch (e) {
      ebookListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _ebookListController.close();
  }
}
