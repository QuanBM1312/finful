import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final num count;
  final TextStyle textStyle;
  final String suffix;

  AnimatedCount({
    Key? key,
    required this.count,
    required this.textStyle,
    this.suffix = '',
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.fastOutSlowIn,
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedCountState();
  }
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _intCount = IntTween(begin: 0, end: 1);
  Tween<double> _doubleCount = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return widget.count is int
        ? Text(
      _intCount.evaluate(animation).toString() + widget.suffix,
      style: widget.textStyle,
    )
        : Text(
      _doubleCount.evaluate(animation).toStringAsFixed(1) + widget.suffix,
      style: widget.textStyle,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.count is int) {
      _intCount = visitor(
        _intCount,
        widget.count,
            (dynamic value) => IntTween(begin: value),
      ) as IntTween;
    } else {
      _doubleCount = visitor(
        _doubleCount,
        widget.count,
            (dynamic value) => Tween<double>(begin: value),
      ) as Tween<double>;
    }
  }
}
