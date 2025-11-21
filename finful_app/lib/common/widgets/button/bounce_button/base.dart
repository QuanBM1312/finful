import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../loadings/dots_loading.dart';
import 'basis.dart';

const Color _DefaultDisabledColor = Color(0xFFAAAAAA);
const Color _kDefaultOpacityColor = Colors.black12;
const double _kRadius = 6.0;

class _RenderLoading extends StatelessWidget {
  const _RenderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DotsLoading(),
    );
  }
}

class _RenderDefaultContent extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;

  const _RenderDefaultContent({
    super.key,
    required this.title,
    required this.onPressed,
    required this.textStyle,
    required this.disabledTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title ?? '',
        style: onPressed != null ? textStyle : disabledTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RenderContent extends StatelessWidget {
  final bool isLoading;
  final Widget? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;
  final String title;
  final Function? onPressed;
  final Alignment align;

  const _RenderContent({
    super.key,
    required this.isLoading,
    required this.prefixIcon,
    required this.mainAxisAlignment,
    required this.textStyle,
    required this.title,
    required this.disabledTextStyle,
    required this.onPressed,
    required this.align,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const _RenderLoading();
    }

    if (prefixIcon != null) {
      return _RenderContentWithPrefixIcon(
        prefixIcon: prefixIcon!,
        mainAxisAlignment: mainAxisAlignment,
        title: title,
        onPressed: onPressed,
        textStyle: textStyle,
        disabledTextStyle: disabledTextStyle,
        align: align,
      );
    }

    return _RenderDefaultContent(
      textStyle: textStyle,
      title: title,
      onPressed: onPressed,
      disabledTextStyle: disabledTextStyle,
    );
  }
}

class _RenderContentWithPrefixIcon extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final String title;
  final Widget prefixIcon;
  final Alignment align;
  final Function? onPressed;
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;

  const _RenderContentWithPrefixIcon({
    Key? key,
    required this.mainAxisAlignment,
    required this.title,
    required this.prefixIcon,
    required this.align,
    required this.onPressed,
    required this.textStyle,
    required this.disabledTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        prefixIcon,
        Text(
          title,
          style: onPressed != null ? textStyle : disabledTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign:
              align == Alignment.centerLeft ? TextAlign.left : TextAlign.center,
        )
      ],
    );
  }
}

class Base extends StatelessWidget {
  final Function? onPressed;
  final double? width;
  final double height;
  final String title;
  final Widget? prefixIcon;
  final Color color;
  final Color? disabledColor;
  final EdgeInsets? padding;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final bool supportLongPress;
  final bool usingPointerDetector;
  final bool isLoading;
  final Alignment align;
  final bool isBorder;
  final bool isBare;
  final Color? opacityColor;

  Base({
    Key? key,
    this.onPressed,
    this.width = double.infinity,
    required this.height,
    required this.title,
    this.prefixIcon,
    required this.color,
    this.disabledColor,
    this.opacityColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.textStyle,
    this.disabledTextStyle,
    this.supportLongPress = false,
    this.usingPointerDetector = false,
    this.isLoading = false,
    this.align = Alignment.center,
    this.isBorder = false,
    this.isBare = false,
  }) : super(key: key);

  MainAxisAlignment get _axisAlignment => (align == Alignment.center ||
          align == Alignment.topCenter ||
          align == Alignment.bottomCenter)
      ? MainAxisAlignment.center
      : (align == Alignment.topLeft ||
              align == Alignment.centerLeft ||
              align == Alignment.bottomLeft)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end;

  @override
  Widget build(BuildContext context) {
    return Basis(
      bounceScale: BounceScale.smaller,
      onPressed: isLoading ? null : onPressed,
      supportLongPress: supportLongPress,
      usingPointerDetector: usingPointerDetector,
      child: (isPressing) {
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: isBorder
                        ? border
                        : Border.all(
                            color: Colors.transparent,
                            width: Dimens.p_0,
                            style: BorderStyle.solid,
                          ),
                    borderRadius:
                        borderRadius ?? BorderRadius.circular(_kRadius),
                    color: onPressed != null
                        ? color
                        : (disabledColor ?? _DefaultDisabledColor),
                  ),
                  padding: width == null
                      ? (padding ??
                          const EdgeInsets.symmetric(horizontal: Dimens.p_16))
                      : null,
                  child: _RenderContent(
                    isLoading: isLoading,
                    prefixIcon: prefixIcon,
                    mainAxisAlignment: _axisAlignment,
                    title: title,
                    textStyle: textStyle ?? Theme.of(context).textTheme.labelLarge!,
                    onPressed: onPressed,
                    disabledTextStyle: disabledTextStyle ??
                        Theme.of(context).textTheme.labelLarge!,
                    align: align,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: !isBare && isPressing
                        ? (opacityColor ?? _kDefaultOpacityColor)
                        : Colors.transparent,
                    borderRadius:
                        borderRadius ?? BorderRadius.circular(_kRadius),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
