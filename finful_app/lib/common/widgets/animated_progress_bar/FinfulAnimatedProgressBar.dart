import 'package:flutter/material.dart';

class FinfulAnimatedProgressBar extends StatefulWidget {
  final double value;
  final double height;
  final Color color;
  final Color backgroundColor;
  final Duration duration;

  const FinfulAnimatedProgressBar({
    super.key,
    required this.value,
    required this.height,
    required this.color,
    this.duration = const Duration(milliseconds: 300),
    required this.backgroundColor,
  });

  @override
  State<FinfulAnimatedProgressBar> createState() => _FinfulAnimatedProgressBarState();
}

class _FinfulAnimatedProgressBarState extends State<FinfulAnimatedProgressBar> {
  double progressWidth = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateProgressWidth();
    });
  }

  @override
  void didUpdateWidget(covariant FinfulAnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateProgressWidth();
    }
  }

  void _updateProgressWidth() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      progressWidth =
      widget.value > 1 ? screenWidth : screenWidth * widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          AnimatedContainer(
            width: progressWidth,
            color: widget.color,
            duration: widget.duration,
          ),
          Expanded(
            child: AnimatedContainer(
              color: widget.backgroundColor,
              duration: widget.duration,
            ),
          )
        ],
      ),
    );
  }
}
