import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/dimensions.dart';

class FinfulLoading extends StatelessWidget {
  final bool isLoading;
  final String? loadingLabel;
  final TextStyle? labelStyle;
  final Widget? child;
  final Color? indicatorColor;
  final Color? backgroundColor;

  const FinfulLoading({
    super.key,
    required this.isLoading,
    this.loadingLabel,
    this.labelStyle,
    this.indicatorColor,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox.shrink(),
        isLoading
            ? Container(
          color: backgroundColor ?? Colors.black.withOpacity(0.5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.p_16,
                horizontal: Dimens.p_8,
              ),
              constraints: const BoxConstraints(
                minWidth: Dimens.p_80,
                minHeight: Dimens.p_80,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Platform.isIOS
                      ? CupertinoActivityIndicator(
                    color: indicatorColor,
                  )
                      : CircularProgressIndicator(
                    color: indicatorColor,
                  ),
                  Text(
                    loadingLabel ?? '',
                    style: labelStyle,
                  ),
                ],
              ),
            ),
          ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
