import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/cast_type.dart';

class AppTextSpan {
  final String startTag;
  final String endTag;
  final TextStyle style;
  final VoidCallback? onTap;

  AppTextSpan(
    this.startTag,
    this.endTag, {
    required this.style,
    this.onTap,
  });

  static List<TextSpan> buildTextSpans(
    String text,
    List<AppTextSpan> textSpans,
  ) {
    final spans = <TextSpan>[];

    var boundary = 0;

    do {
      var found = false;
      dynamic textSpan;
      var beginIndex = -1;
      var endIndex = -1;
      for (var i = 0; i < textSpans.length; i++) {
        final searchTextSpan = textSpans[i];
        final searchBeginIndex =
            text.indexOf(searchTextSpan.startTag, boundary);
        if (searchBeginIndex == -1) {
          if (i == textSpans.length - 1 && !found) {
            spans.add(TextSpan(text: text.substring(boundary)));
            boundary = text.length;
          }
          continue;
        }
        if (searchBeginIndex < beginIndex || beginIndex == -1) {
          beginIndex = searchBeginIndex;
          textSpan = searchTextSpan;
          found = true;

          endIndex = text.indexOf(textSpan.endTag, beginIndex);
          if (endIndex == -1) {
            if (i == textSpans.length - 1) {
              spans.add(TextSpan(text: text.substring(boundary)));
              boundary = text.length;
            }
            found = false;
            continue;
          }
        }
      }
      if (found) {
        spans.add(TextSpan(text: text.substring(boundary, beginIndex)));
        final spanText = text.substring(
            asT<int>(beginIndex + textSpan.startTag.length)!, endIndex);
        final tapGesture =
            textSpan.onTap != null ? TapGestureRecognizer() : null;
        tapGesture?.onTap = textSpan.onTap;
        spans.add(
          TextSpan(
            text: spanText,
            style: textSpan.style,
            recognizer: tapGesture,
          ),
        );
        boundary = asT<int>(endIndex + textSpan.endTag.length)!;
      }
    } while (boundary < text.length);

    return spans;
  }
}
