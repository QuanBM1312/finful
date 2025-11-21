import 'package:flutter/material.dart';

const _kDefaultAnimationDuration = 150; //miliseconds

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final double size;
  final double iconPadding;
  final String? title;
  final TextStyle? titleStyle;
  final int? duration;

  AnimatedIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.duration,
    this.title,
    this.size = 32,
    this.iconPadding = 0,
    this.titleStyle,
  }) : super(key: key);

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: widget.duration ?? _kDefaultAnimationDuration,
      ),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  Future<void> _onPressed() async {
    if (_controller.isAnimating) {
      _controller.reset();
    }
    await _controller.forward();
    _controller.reset();
    widget.onPressed?.call();
  }

  double get size => widget.size + widget.iconPadding * 2;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      child: GestureDetector(
        onTap: _onPressed,
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              width: size,
              height: size,
              child: Padding(
                padding: EdgeInsets.all(widget.iconPadding),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.icon,
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) {
                        return Transform.scale(
                          scale: 1 + _animation.value,
                          child: Opacity(
                            opacity: 1 - _animation.value,
                            child: widget.icon,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (widget.title?.isNotEmpty ?? false)
              Text(
                widget.title!,
                style: widget.titleStyle ?? Theme.of(context).textTheme.labelLarge,
              )
          ],
        ),
      ),
    );
  }
}
