class Puzzle {
  late String id;
  late String fen;
  late int rating;
  late String url;
  late Level level;
  late int pieces;
  late Player player;
  late String audio;
  late String image;

  Puzzle(
      {required this.id,
      required this.fen,
      required this.rating,
      required this.url,
      required this.level,
      required this.pieces,
      required this.player,
      required this.audio,
      required this.image});

  Puzzle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fen = json['fen'];
    rating = int.parse(json['rating']);
    url = json['url'];
    pieces = json['pieces'];
    player = Player.values.firstWhere((e) =>
        e.toString().split('.')[1].toUpperCase() ==
        json['player'].toUpperCase());
    audio = json['audio'];
    image = json['image'];
    if (this.rating < 1200)
      this.level = Level.EASY;
    else if (this.rating <= 1800)
      this.level = Level.MEDIUM;
    else
      this.level = Level.HARD;
  }
}

enum Player { BLACK, WHITE }
enum Level { EASY, MEDIUM, HARD }
