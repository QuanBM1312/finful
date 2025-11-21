
import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';

class SectionOptionCard extends StatelessWidget {
  const SectionOptionCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  final String title;
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
          border: Border.all(
            color: !isSelected ?
            FinfulColor.inputBorderDefault : FinfulColor.brandPrimary,
            width: Dimens.p_1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(FinfulDimens.radiusMd)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.5,
          horizontal: Dimens.p_25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w400,
                height: Dimens.p_21 / Dimens.p_14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
