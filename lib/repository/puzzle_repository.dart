import 'dart:async';
import 'dart:convert';
import 'package:chessradio/model/puzzle.dart';
import 'package:http/http.dart';

class PuzzleRepository {
  final String url =
      "https://raw.githubusercontent.com/chessradio/chessradio-db/main/puzzles.json";

  Future<List<Puzzle>> fetchPuzzles() async {
    Response res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Puzzle> puzzles = body
          .map(
            (dynamic item) => Puzzle.fromJson(item),
          )
          .toList();
      return puzzles;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
