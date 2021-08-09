class Puzzle {
  late String id;
  late String fen;
  late int rating;
  late String url;
  late int pieces;
  late Player player;
  late String audio;
  late String image;

  Puzzle(
      {required this.id,
      required this.fen,
      required this.rating,
      required this.url,
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
    player =
        json['player'].toUpperCase() == 'WHITE' ? Player.WHITE : Player.BLACK;
    audio = json['audio'];
    image = json['image'];
  }
}

enum Player { BLACK, WHITE }
