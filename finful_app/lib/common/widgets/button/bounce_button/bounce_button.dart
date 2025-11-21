import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import 'base.dart';

class BounceButton extends Base {
  BounceButton(
    Key key, {
    double? width,
    required double height,
    required String title,
    Widget? prefixIcon,
    required Color color,
    TextStyle? textStyle,
    Alignment align = Alignment.center,
    VoidCallback? onPressed,
    bool isBorder = false,
    BoxBorder? border,
    BorderRadius? borderRadius,
    bool isLoading = false,
    Color? disabledColor,
    TextStyle? disabledTextStyle,
    Color? opacityColor,
    EdgeInsets? padding,
    bool usingPointerDetector = false,
    bool isBare = false,
  }) : super(
          color: color,
          height: height,
          title: title,
          textStyle: textStyle,
          prefixIcon: prefixIcon,
          supportLongPress: false,
          align: align,
          width: width,
          disabledColor: disabledColor,
          disabledTextStyle: disabledTextStyle,
          border: isBorder ? border : null,
          isBorder: isBorder,
          borderRadius: borderRadius,
          isLoading: isLoading,
          opacityColor: opacityColor,
          padding: padding,
          usingPointerDetector: usingPointerDetector,
          isBare: isBare,
          onPressed: onPressed,
        );

  factory BounceButton.primary(
    Key key, {
    double? width,
    required String title,
    required VoidCallback? onPressed,
    bool isLoading = false,
    required Color color,
    required TextStyle textStyle,
    required Color disabledColor,
    required TextStyle disabledTextStyle,
  }) {
    return BounceButton(
      key,
      width: width,
      height: Dimens.p_48,
      title: title,
      color: color,
      textStyle: textStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  factory BounceButton.primaryIcon(
    Key key, {
    double? width,
    required String title,
    required VoidCallback? onPressed,
    required Widget icon,
    bool isLoading = false,
    required Color color,
    required TextStyle textStyle,
    required Color disabledColor,
    required TextStyle disabledTextStyle,
  }) {
    return BounceButton(
      key,
      width: width,
      height: Dimens.p_48,
      title: title,
      color: color,
      textStyle: textStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      onPressed: onPressed,
      isLoading: isLoading,
      prefixIcon: icon,
    );
  }

  factory BounceButton.secondary(
    Key key, {
    double? width,
    required String title,
    required VoidCallback? onPressed,
    bool isLoading = false,
    required Color color,
    required TextStyle textStyle,
    required Color disabledColor,
    required TextStyle disabledTextStyle,
  }) {
    return BounceButton(
      key,
      width: width,
      height: Dimens.p_48,
      title: title,
      color: color,
      textStyle: textStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }

  factory BounceButton.secondaryIcon(
    Key key, {
    double? width,
    required String title,
    required VoidCallback? onPressed,
    required Widget icon,
    bool isLoading = false,
    required Color color,
    required TextStyle textStyle,
    required Color disabledColor,
    required TextStyle disabledTextStyle,
  }) {
    return BounceButton(
      key,
      width: width,
      height: Dimens.p_48,
      title: title,
      color: color,
      textStyle: textStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      onPressed: onPressed,
      isLoading: isLoading,
      prefixIcon: icon,
    );
  }
}
