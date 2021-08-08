import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/api_provider.dart';

class PuzzlesRepository {
  final ApiProvider _provider = ApiProvider();

  Future<List<Puzzle>> fetchPuzzles() async {
    print('fetching all puzzles');
    final response = await _provider.get();
    List<Puzzle> original = (response as List)
        .map((jsonPuzzle) => Puzzle.fromJson(jsonPuzzle))
        .toList();
    original.shuffle();
    return original.take(20).toList();
  }
}
