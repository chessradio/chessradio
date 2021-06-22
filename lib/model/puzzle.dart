class Puzzle {
  final String _title;
  final Level _level;
  final PieceColor _playingAs;
  final String _audioAsset;
  final String _audioSolutionAsset;
  final String _imageSolutionAsset;

  Puzzle(this._title, this._level, this._playingAs, this._audioAsset,
      this._audioSolutionAsset, this._imageSolutionAsset);

  String get title => _title;
  Level get level => _level;
  PieceColor get playingAs => _playingAs;
  String get audioPuzzle => _audioAsset;
  String get audioSolutionAsset => _audioSolutionAsset;
  String get imageSolutionAsset => _imageSolutionAsset;
}

enum Level { EASY, MEDIUM, HARD }

enum PieceColor { BLACK, WHITE }
