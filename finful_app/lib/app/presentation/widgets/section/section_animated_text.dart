import 'package:flutter/material.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class SectionAnimatedText extends StatelessWidget {
  const SectionAnimatedText({
    super.key,
    required this.value,
    this.textStyle,
    this.textAlign,
  });

  final String value;
  final TextStyle? textStyle;
  final TextAlignment? textAlign;

  @override
  Widget build(BuildContext context) {
    return OffsetText(
      text: value,
      duration: const Duration(milliseconds: 50),
      type: AnimationType.word,
      slideType: SlideAnimationType.leftRight,
      textAlignment: textAlign ?? TextAlignment.start,
      textStyle: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
