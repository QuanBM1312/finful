import 'package:flutter/material.dart';

enum BounceScale { bigger, smaller }

const double _kDefaultAnimValue = 1.0;
const int _kButtonAnimDuration = 100;
const double _kUpperBound = 0.01;

typedef BasisRender = Widget Function(bool isPressing);

class Basis extends StatefulWidget {
  final Function? onPressed;
  final BasisRender child;
  final Alignment align;
  final BounceScale bounceScale;
  final bool usingPointerDetector;
  final bool supportLongPress;

  Basis({
    Key? key,
    required this.child,
    required this.onPressed,
    this.align = Alignment.center,
    this.bounceScale = BounceScale.smaller,
    this.usingPointerDetector = false,
    this.supportLongPress = false,
  }) : super(key: key);

  @override
  _BasisState createState() => _BasisState();
}

class _BasisState extends State<Basis> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  bool _autoReverse = false;
  bool _startLongPress = false;
  bool _isCanceling = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _kButtonAnimDuration),
      lowerBound: 0.0,
      upperBound: _kUpperBound,
    )..addListener(() {
        if (_autoReverse && _controller.value == _controller.upperBound) {
          _autoReverse = false;
          _controller.reverse();
        } else {
          if (_controller.status == AnimationStatus.dismissed &&
              widget.onPressed != null) {
            if (!_isCanceling) {
              widget.onPressed!();
            } else {
              _isCanceling = false;
            }

            if (widget.supportLongPress && _startLongPress) {
              _autoReverse = true;
              _controller.forward();
            }
          }

          setState(() {});
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(dynamic event) {
    _controller.forward();
  }

  void _onTapUp(dynamic event) {
    _proceedTapUp();
  }

  void _proceedTapUp() {
    if (_controller.value < _controller.upperBound) {
      _autoReverse = true;
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scale = widget.bounceScale == BounceScale.smaller
        ? _kDefaultAnimValue - _controller.value
        : _kDefaultAnimValue + _controller.value;

    return widget.usingPointerDetector
        ? Listener(
            onPointerDown: _onTapDown,
            onPointerUp: _onTapUp,
            onPointerCancel: (_) {
              if (!widget.supportLongPress) {
                _isCanceling = true;
                _proceedTapUp();
              }
            },
            child: widget.supportLongPress
                ? GestureDetector(
                    onLongPress: () {
                      _startLongPress = true;
                      _controller.reverse();
                    },
                    onLongPressUp: () {
                      _startLongPress = false;
                      _proceedTapUp();
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.scale(
                          scale: _scale,
                          child: child,
                        );
                      },
                      child: widget.child(_scale != _kDefaultAnimValue),
                    ),
                  )
                : AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.scale(
                        scale: _scale,
                        child: child,
                      );
                    },
                    child: widget.child(_scale != _kDefaultAnimValue),
                  ),
          )
        : GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: () {
              if (!widget.supportLongPress) {
                _isCanceling = true;
                _proceedTapUp();
              }
            },
            onLongPress: widget.supportLongPress
                ? () {
                    _startLongPress = true;
                    _controller.reverse();
                  }
                : null,
            onLongPressUp: widget.supportLongPress
                ? () {
                    _startLongPress = false;
                    _proceedTapUp();
                  }
                : null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.scale(
                  scale: _scale,
                  child: child,
                );
              },
              child: widget.onPressed == null
                  ? widget.child(false)
                  : widget.child(_scale != _kDefaultAnimValue),
            ),
          );
  }
}
