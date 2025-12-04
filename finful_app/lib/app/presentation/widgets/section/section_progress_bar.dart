import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';

class SectionProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final double height;
  final BorderRadius? borderRadius;
  final Color? foregroundColor;

  const SectionProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.height = Dimens.p_6,
    this.borderRadius,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = (current / total).clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Background
            Container(
              color: FinfulColor.progressBarBackground,
            ),
            // Progress
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                color: foregroundColor ?? FinfulColor.progressBarForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}