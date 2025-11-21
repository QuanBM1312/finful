import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';

class InkButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color? highlightColor;
  final Color? splashColor;
  final Widget child;
  final Alignment align;
  final Color? bgColor;
  final Decoration? decoration;
  final BorderRadius? customBorder;

  InkButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.onLongPress,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = Dimens.p_8,
    this.highlightColor,
    this.splashColor,
    this.align = Alignment.center,
    this.bgColor,
    this.decoration,
    this.customBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        highlightColor: highlightColor ?? Colors.transparent,
        splashColor: splashColor ?? Colors.transparent,
        borderRadius: customBorder ?? BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          alignment: align,
          padding: padding ?? EdgeInsets.zero,
          decoration: decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
          child: child,
        ),
      ),
    );
  }
}
