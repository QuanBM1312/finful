import 'package:finful_app/app/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/dimensions.dart';
import '../../../../common/widgets/button/bounce_button/bounce_button.dart';
import '../../../theme/dimens.dart';


const _kButtonRadius = BorderRadius.all(Radius.circular(FinfulDimens.radiusMd));

const _kDefaultButtonKey = ValueKey('finful_button');
const _kDefaultPrimaryButtonKey = ValueKey('finful_primary_button');
const _kDefaultSecondaryButtonKey = ValueKey('finful_secondary_button');
const _kDefaultBorderButtonKey = ValueKey('finful_border_button');

const _kPrimaryColor = FinfulColor.brandPrimary;
const _kSecondaryColor = FinfulColor.white;
const _kDisabledColor = FinfulColor.stroke;

const _kPrimaryTextStyle = TextStyle(
  fontSize: Dimens.p_14,
  height: Dimens.p_14 / Dimens.p_14,
  fontWeight: FontWeight.w600,
  color: FinfulColor.white,
);

final _kSecondaryTextStyle = TextStyle(
  fontSize: Dimens.p_14,
  height: Dimens.p_14 / Dimens.p_14,
  fontWeight: FontWeight.w600,
  color: FinfulColor.btnTextInBlack,
);
const _kDisabledTextStyle = TextStyle(
  fontSize: Dimens.p_14,
  height: Dimens.p_14 / Dimens.p_14,
  fontWeight: FontWeight.w600,
  color: FinfulColor.disabled,
);

class FinfulButton extends BounceButton {
  FinfulButton({
    Key? key,
    required String title,
    double height = FinfulDimens.buttonHeightMd,
    Color color = FinfulColor.brandPrimary,
    TextStyle? textStyle,
    VoidCallback? onPressed,
    double? width,
    Widget? prefixIcon,
    Alignment align = Alignment.center,
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
    key ?? _kDefaultButtonKey,
    onPressed: onPressed,
    title: title,
    height: height,
    color: color,
    textStyle: textStyle,
    width: width,
    prefixIcon: prefixIcon,
    align: align,
    isBorder: isBorder,
    border: border,
    borderRadius: borderRadius ?? _kButtonRadius,
    isLoading: isLoading,
    disabledColor: disabledColor ?? _kDisabledColor,
    disabledTextStyle: disabledTextStyle ?? _kDisabledTextStyle,
    opacityColor: opacityColor,
    padding: padding,
    usingPointerDetector: usingPointerDetector,
    isBare: isBare,
  );

  factory FinfulButton.primary({
    Key? key,
    double? width,
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color color = _kPrimaryColor,
    TextStyle? textStyle,
    Color? disabledColor,
    TextStyle? disabledTextStyle,
    Widget? prefixIcon,
  }) {
    return FinfulButton(
      key: key ?? _kDefaultPrimaryButtonKey,
      width: width,
      title: title,
      onPressed: onPressed,
      isLoading: isLoading,
      color: color,
      textStyle: textStyle ?? _kPrimaryTextStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      prefixIcon: prefixIcon,
    );
  }

  factory FinfulButton.secondary({
    Key? key,
    double? width,
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color color = _kSecondaryColor,
    TextStyle? textStyle,
    Color? disabledColor,
    TextStyle? disabledTextStyle,
    Widget? prefixIcon,
  }) {
    return FinfulButton(
      key: key ?? _kDefaultSecondaryButtonKey,
      width: width,
      title: title,
      onPressed: onPressed,
      isLoading: isLoading,
      color: color,
      textStyle: textStyle ?? _kSecondaryTextStyle,
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      prefixIcon: prefixIcon,
    );
  }

  factory FinfulButton.border({
    Key? key,
    double? width,
    required String title,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isBare = false,
    Color? bgColor,
    required Color borderColor,
    TextStyle? textStyle,
    Color? disabledColor,
    TextStyle? disabledTextStyle,
    Widget? prefixIcon,
  }) {
    return FinfulButton(
      key: key ?? _kDefaultBorderButtonKey,
      width: width,
      title: title,
      isBorder: true,
      isBare: isBare,
      color: bgColor ?? Colors.transparent,
      border: BoxBorder.all(
        width: Dimens.p_1,
        style: BorderStyle.solid,
        color: borderColor,
      ),
      onPressed: onPressed,
      isLoading: isLoading,
      textStyle: textStyle ?? _kSecondaryTextStyle.copyWith(
        color: borderColor
      ),
      disabledColor: disabledColor,
      disabledTextStyle: disabledTextStyle,
      prefixIcon: prefixIcon,
    );
  }
}
