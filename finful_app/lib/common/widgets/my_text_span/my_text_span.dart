import 'package:flutter/material.dart';
import 'mark_text_styles.dart';

extension SpanLabelTheme on ThemeData {
  TextStyle get spanLabelDefault => primaryTextTheme.bodyLarge!;

  TextStyle get spanLabelBold => primaryTextTheme.bodyLarge!;

  TextStyle get spanLabelItalic => primaryTextTheme.bodyLarge!;

  TextStyle get spanLabelBoldItalic => primaryTextTheme.bodyLarge!;
}

class Tag {
  static const String startBold = '{b}';
  static const String endBold = '{/b}';

  static const String startItalic = '{i}';
  static const String endItalic = '{/i}';

  static const String startBoldItalic = '{bi}';
  static const String endBoldItalic = '{/bi}';
}

class MyTextSpan extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  final TextStyle? defaultStyle;
  final TextStyle? boldStyle;
  final TextStyle? italicStyle;
  final TextStyle? boldItalicStyle;

  final VoidCallback? boldTapped;
  final VoidCallback? italicTapped;
  final VoidCallback? boldItalicTapped;

  final TextOverflow? overflow;
  final int? maxLines;

  MyTextSpan({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.defaultStyle,
    this.boldStyle,
    this.italicStyle,
    this.boldItalicStyle,
    this.overflow,
    this.maxLines,
    this.boldTapped,
    this.italicTapped,
    this.boldItalicTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        style: defaultStyle ?? Theme.of(context).spanLabelDefault,
        children: AppTextSpan.buildTextSpans(
          text,
          <AppTextSpan>[
            AppTextSpan(
              Tag.startBold,
              Tag.endBold,
              style: boldStyle ?? Theme.of(context).spanLabelBold,
              onTap: boldTapped,
            ),
            AppTextSpan(
              Tag.startItalic,
              Tag.endItalic,
              style: italicStyle ?? Theme.of(context).spanLabelItalic,
              onTap: italicTapped,
            ),
            AppTextSpan(
              Tag.startBoldItalic,
              Tag.endBoldItalic,
              style: boldItalicStyle ?? Theme.of(context).spanLabelBoldItalic,
              onTap: boldItalicTapped,
            ),
          ],
        ),
      ),
    );
  }
}
