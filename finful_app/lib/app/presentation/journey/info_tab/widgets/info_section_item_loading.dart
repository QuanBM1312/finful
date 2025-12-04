import 'package:finful_app/app/presentation/widgets/app_loading/finful_skeleton_loading.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';

class InfoSectionItemLoading extends StatelessWidget {
  const InfoSectionItemLoading({super.key});

  double get cardWidth => Dimens.p_180 * 1.08;
  double get cardHeight => Dimens.p_180;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: FinfulSkeletonLoading(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.p_10)),
          child: Container(
            decoration: BoxDecoration(
              color: FinfulColor.blackBaseSkeletonColor,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.p_10)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.3)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.p_20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Dimens.p_44,
                        height: Dimens.p_44,
                        color: FinfulColor.blackHighLightSkeletonColor,
                      ),
                      SizedBox(height: Dimens.p_11),
                      Container(
                        height: Dimens.p_20,
                        width: Dimens.p_120,
                        color: FinfulColor.blackHighLightSkeletonColor,
                      ),
                      SizedBox(height: Dimens.p_18),
                      Container(
                        height: Dimens.p_40,
                        width: Dimens.p_140,
                        decoration: BoxDecoration(
                          color: FinfulColor.blackHighLightSkeletonColor,
                          borderRadius: BorderRadius.circular(Dimens.p_5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}