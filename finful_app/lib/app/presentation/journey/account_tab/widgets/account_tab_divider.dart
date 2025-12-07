import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';

class AccountTabDivider extends StatelessWidget {
  const AccountTabDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimens.p_1,
      color: FinfulColor.white.withValues(alpha: 0.3),
    );
  }
}