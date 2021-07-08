import 'dart:async';

import 'package:chessradio/model/puzzle.dart';
import 'package:chessradio/networking/api_provider.dart';

class PuzzlesRepository {
  final ApiProvider _provider = ApiProvider();

  Future<List<Puzzle>> fetchPuzzles() async {
    print('fetching all puzzles');
    final response = await _provider.get();
    return (response as List)
        .map((jsonPuzzle) => Puzzle.fromJson(jsonPuzzle))
        .toList();
  }
}
