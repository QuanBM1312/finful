
import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';

class DashboardStaticSchedule extends StatelessWidget {
  const DashboardStaticSchedule({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                L10n.of(context).translate('dashboard_static_schedule_header_title'),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  height: Dimens.p_14/ Dimens.p_16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(width: Dimens.p_80),
          ],
        ),
        const SizedBox(height: Dimens.p_15),
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.p_10)),
          child: Container(
            decoration: BoxDecoration(
              color: FinfulColor.bgDisabled,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.p_10)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.p_42,
              vertical: Dimens.p_24,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgSchedule,
                    width: Dimens.p_44,
                    height: Dimens.p_44,
                  ),
                  const SizedBox(height: Dimens.p_10),
                  Text(
                    L10n.of(context).translate('dashboard_static_schedule_title'),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: FinfulColor.textWOpacity60,
                      height: Dimens.p_16/ Dimens.p_12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
