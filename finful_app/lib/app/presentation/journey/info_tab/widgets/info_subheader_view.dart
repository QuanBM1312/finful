import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/context_extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';

class InfoSubHeaderView extends StatelessWidget {
  const InfoSubHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            L10n.of(context).translate('dashboard_none_finalPlan_subHeader_title'),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: FinfulColor.textWOpacity60,
              height: Dimens.p_18/ Dimens.p_12,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
        ),
        SizedBox(width: context.queryWidth * 0.4),
      ],
    );
  }
}