import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/context_extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';

class SectionFamilySupportQaSubmitResult extends StatelessWidget {
  const SectionFamilySupportQaSubmitResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: context.queryHeight / 5),
        Center(
          child: SizedBox(
            width: Dimens.p_110,
            height: Dimens.p_110,
            child: CircularProgressIndicator(
              color: FinfulColor.brandPrimary,
              backgroundColor: FinfulColor.brandPrimary.withValues(alpha: 0.30),
              strokeWidth: Dimens.p_15,
            ),
          ),
        ),
        const SizedBox(height: Dimens.p_60),
        Text(
          L10n.of(context)
              .translate('section_familySupport_result_submitting'),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
