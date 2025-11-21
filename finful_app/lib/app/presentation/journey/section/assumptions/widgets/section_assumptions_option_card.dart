import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';

class _ContentTile extends StatelessWidget {
  const _ContentTile({
    super.key,
    required this.label,
    required this.value,
    required this.maxLines,
  });

  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: Dimens.p_10,
            fontWeight: FontWeight.w300,
            height: Dimens.p_10 / Dimens.p_10,
          ),
        ),
        const SizedBox(height: Dimens.p_3),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: Dimens.p_10,
            fontWeight: FontWeight.w500,
            height: Dimens.p_10 / Dimens.p_10,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}


class SectionAssumptionsOptionCard extends StatelessWidget {
  const SectionAssumptionsOptionCard({
    super.key,
    required this.headerTitle,
    required this.leftTitle,
    required this.rightLabel,
    required this.rightTitle,
    required this.isSelected,
    required this.onPressed,
  });

  final String headerTitle;
  final String leftTitle;
  final String rightTitle;
  final String rightLabel;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.all(
          Radius.circular(FinfulDimens.radiusLg)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FinfulColor.cardBg,
          border: Border.all(
            color: !isSelected ?
            FinfulColor.cardBorder : FinfulColor.brandPrimary,
            width: Dimens.p_1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(FinfulDimens.radiusLg)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 19.5,
          horizontal: Dimens.p_16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Dimens.p_17,
              height: Dimens.p_17,
              decoration: BoxDecoration(
                color: FinfulColor.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimens.p_17)),
              ),
              padding: EdgeInsets.all(Dimens.p_1),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: !isSelected ?
                  FinfulColor.cardBg : FinfulColor.brandPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.p_17)),
                ),
              ),
            ),
            const SizedBox(width: Dimens.p_11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerTitle,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: !isSelected ?
                      FinfulColor.textW : FinfulColor.brandPrimary,
                      height: Dimens.p_12 / Dimens.p_12,
                    ),
                  ),
                  const SizedBox(height: Dimens.p_19),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Dimens.p_92,
                        child: _ContentTile(
                          label: L10n.of(context)
                              .translate('section_radio_option_left_label'),
                          value: leftTitle,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(width: Dimens.p_26),
                      Expanded(
                        child: _ContentTile(
                          label: rightLabel,
                          value: rightTitle,
                          maxLines: 4,
                        ),
                      ),
                    ],
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
