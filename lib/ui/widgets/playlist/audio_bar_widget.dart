import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioBarWidget extends StatelessWidget {
  final AudioPlayer player;

  AudioBarWidget(this.player);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        return StreamBuilder<PositionData>(
          stream: Rx.combineLatest2<Duration, Duration, PositionData>(
              player.positionStream,
              player.bufferedPositionStream,
              (position, bufferedPosition) =>
                  PositionData(position, bufferedPosition)),
          builder: (context, snapshot) {
            final positionData =
                snapshot.data ?? PositionData(Duration.zero, Duration.zero);
            var position = positionData.position;
            if (position > duration) {
              position = duration;
            }
            var bufferedPosition = positionData.bufferedPosition;
            if (bufferedPosition > duration) {
              bufferedPosition = duration;
            }
            return SeekBar(
              duration: duration,
              position: position,
              bufferedPosition: bufferedPosition,
              onChangeEnd: (newPosition) {
                player.seek(newPosition);
              },
            );
          },
        );
      },
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      inactiveTrackColor: Colors.grey,
      activeTrackColor: Colors.black,
      thumbColor: Colors.black,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            activeTrackColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade300,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            trackHeight: 1,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
