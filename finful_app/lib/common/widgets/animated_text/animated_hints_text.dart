import 'package:flutter/material.dart';

import '../../animated/character.dart';

const int _kFullHintShowingTime = 1500; //milliseconds

class AnimatedHintsText extends StatefulWidget {
  final List<String> hints;
  final TextStyle style;

  AnimatedHintsText({
    Key? key,
    this.hints = const [],
    required this.style,
  }) : super(key: key);

  @override
  State<AnimatedHintsText> createState() => _AnimatedHintsTextState();
}

class _AnimatedHintsTextState extends State<AnimatedHintsText>
    with TickerProviderStateMixin {
  String _currentHint = '';
  int _currentHintIndex = 0;
  late IntTween _tween;

  @override
  void initState() {
    super.initState();
    if (widget.hints.isNotEmpty) {
      _currentHint = widget.hints.first;
    }
    _tween = IntTween(begin: 0, end: _currentHint.length);
  }

  @override
  void didUpdateWidget(covariant AnimatedHintsText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hints.length != widget.hints.length) {
      _currentHintIndex = 0;
    }
  }

  Future<void> onEnd() async {
    if (_tween.begin == 0) {
      await Future.delayed(const Duration(milliseconds: _kFullHintShowingTime));
      _tween = IntTween(begin: widget.hints.length, end: 0);
    } else {
      if (_currentHintIndex == widget.hints.length - 1) {
        _currentHintIndex = 0;
      } else {
        _currentHintIndex += 1;
      }
      _currentHint = widget.hints[_currentHintIndex];
      _tween = IntTween(begin: 0, end: _currentHint.length);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCharacter(
      onEnd: onEnd,
      style: widget.style,
      currentHint: _currentHint,
      tween: _tween,
    );
  }
}
