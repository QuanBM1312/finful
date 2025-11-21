import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/constants.dart';
import 'package:finful_app/core/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

const _kShowAnimationDuration = Duration(milliseconds: 1200);
const _kHideAnimationDuration = Duration(milliseconds: 200);
const _kDisplayDuration = Duration(milliseconds: 4000);

class _SnackBarView extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? icon;

  const _SnackBarView({
    super.key,
    this.title,
    this.message,
    this.icon,
  });

  const _SnackBarView.info({
    super.key,
    this.title,
    this.message,
    this.icon = const Icon(
      Icons.info,
      color: FinfulColor.brandPrimary,
      size: Dimens.p_24,
    ),
  });

  const _SnackBarView.warning({
    super.key,
    this.title,
    this.message,
    this.icon = const Icon(
      Icons.warning_rounded,
      color: FinfulColor.brandSecondary,
      size: Dimens.p_24,
    ),
  });

  const _SnackBarView.error({
    super.key,
    this.title,
    this.message,
    this.icon = const Icon(
      Icons.error,
      color: FinfulColor.error,
      size: Dimens.p_24,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      FinfulDimens.radiusMd,
    );
    return Material(
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(FinfulDimens.md),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: FinfulColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: Dimens.p_2,
              blurRadius: Dimens.p_4,
              offset: const Offset(FinfulDimens.zero, Dimens.p_4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: FinfulDimens.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title.isNotNullAndEmpty)
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: FinfulColor.black12,
                      ),
                    ),
                  if (message.isNotNullAndEmpty)
                    Text(
                        message!,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: FinfulColor.black12,
                          fontWeight: FontWeight.w400,
                        ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinfulSnackBar {
  FinfulSnackBar._();

  static void info({
    String? title,
    String? message,
    Duration showAnimationDuration = _kShowAnimationDuration,
    Duration hideAnimationDuration = _kHideAnimationDuration,
    Duration displayDuration = _kDisplayDuration,
    VoidCallback? onTap,
  }) {
    showTopSnackBar(
      AppRoutes.shared.navigatorKey.currentState!.overlay!,
      _SnackBarView.info(
        title: title,
        message: message,
      ),
      onTap: onTap,
      animationDuration: showAnimationDuration,
      reverseAnimationDuration: hideAnimationDuration,
      displayDuration: displayDuration,
    );
  }

  static void error({
    String? title,
    String? message,
    Duration showAnimationDuration = _kShowAnimationDuration,
    Duration hideAnimationDuration = _kHideAnimationDuration,
    Duration displayDuration = _kDisplayDuration,
    VoidCallback? onTap,
  }) {
    showTopSnackBar(
      AppRoutes.shared.navigatorKey.currentState!.overlay!,
      _SnackBarView.error(
        title: title,
        message: message,
      ),
      onTap: onTap,
      animationDuration: showAnimationDuration,
      reverseAnimationDuration: hideAnimationDuration,
      displayDuration: displayDuration,
    );
  }

  static void warning({
    String? title,
    String? message,
    Duration showAnimationDuration = _kShowAnimationDuration,
    Duration hideAnimationDuration = _kHideAnimationDuration,
    Duration displayDuration = _kDisplayDuration,
    VoidCallback? onTap,
  }) {
    showTopSnackBar(
      AppRoutes.shared.navigatorKey.currentState!.overlay!,
      _SnackBarView.warning(
        title: title,
        message: message,
      ),
      onTap: onTap,
      animationDuration: showAnimationDuration,
      reverseAnimationDuration: hideAnimationDuration,
      displayDuration: displayDuration,
    );
  }
}
