import 'package:flutter/material.dart';

const int _kCharacterAppearanceTime = 60; //milliseconds

class AnimatedCharacter extends StatelessWidget {
  final Function onEnd;
  final String currentHint;
  final TextStyle style;
  final Tween<int>? tween;

  AnimatedCharacter({
    required this.onEnd,
    required this.currentHint,
    required this.style,
    this.tween,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: tween ?? IntTween(begin: 0, end: currentHint.length),
      duration: Duration(
        milliseconds: _kCharacterAppearanceTime * currentHint.length,
      ),
      onEnd: () {
        onEnd.call();
      },
      builder: (_, value, __) {
        return Text(
          currentHint.substring(0, value),
          style: style,
        );
      },
    );
  }
}
