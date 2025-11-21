import 'package:flutter/material.dart';

import '../../../../common/widgets/loadings/skeleton_loading.dart';
import '../../../theme/colors.dart';

class FinfulSkeletonLoading extends StatelessWidget {
  const FinfulSkeletonLoading({
    super.key,
    required this.child,
    this.color,
    this.highLightColor,
  });

  final Widget child;
  final Color? color;
  final Color? highLightColor;

  @override
  Widget build(BuildContext context) {
    return SkeletonLoading.instance(
      color: color ?? FinfulColor.blackBaseSkeletonColor,
      highLightColor: highLightColor ?? FinfulColor.blackHighLightSkeletonColor,
      child: child,
    );
  }
}
