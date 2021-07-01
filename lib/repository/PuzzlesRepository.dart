import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/ApiProvider.dart';

class PuzzlessRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<Puzzle>> fetchPuzzles() async {
    print('fetching all puzzles');
    final response = await _provider.get(
        "https://raw.githubusercontent.com/chessradio/chessradio-db/main/puzzles.json");
    return (response as List).map((puzzle) => Puzzle.fromJson(puzzle)).toList();
  }
}
