class Puzzle {
  late String title;
  late Level level;
  late PieceColor playingAs;
  late String audioAsset;
  late String audioSolutionAsset;
  late String imageSolutionAsset;

  Puzzle(
      {required this.title,
      required this.level,
      required this.playingAs,
      required this.audioAsset,
      required this.audioSolutionAsset,
      required this.imageSolutionAsset});

  Puzzle.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = Level.values.firstWhere((e) =>
        e.toString().split('.')[1].toUpperCase() ==
        json['level'].toUpperCase());
    playingAs = PieceColor.values.firstWhere((e) =>
        e.toString().split('.')[1].toUpperCase() ==
        json['playingAs'].toUpperCase());
    audioAsset = json['audioAsset'];
    audioSolutionAsset = json['solution']['audioAsset'];
    imageSolutionAsset = json['solution']['imageAsset'];
  }
}

enum Level { EASY, MEDIUM, HARD }

enum PieceColor { BLACK, WHITE }
