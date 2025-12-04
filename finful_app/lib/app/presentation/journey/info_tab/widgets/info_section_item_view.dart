import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';

class InfoSectionItemView extends StatelessWidget {
  const InfoSectionItemView({
    super.key,
    required this.isCompleted,
    required this.isActivated,
    required this.bgImage,
    required this.image,
    required this.content,
    required this.onPressed,
  });

  final bool isCompleted;
  final bool isActivated;
  final String bgImage;
  final String image;
  final String content;
  final VoidCallback onPressed;

  double get cardWidth => Dimens.p_180 * 1.08;

  double get cardHeight => Dimens.p_180;

  BorderRadius get cardRadius => BorderRadius.all(Radius.circular(Dimens.p_10));

  String _statusTxt(BuildContext context) {
    if (isCompleted) {
      return L10n.of(context).translate('dashboard_section_completed_btn_title');
    }

    if (isActivated) {
      return L10n.of(context).translate('dashboard_section_start_btn_title');
    }

    return L10n.of(context).translate('dashboard_section_inactive_btn_title');
  }

  bool get isDisabledCard {
    return !isActivated || isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: cardRadius,
      ),
      child: AbsorbPointer(
        absorbing: isDisabledCard,
        child: InkWell(
          onTap: onPressed,
          borderRadius: cardRadius,
          child: ClipRRect(
            borderRadius: cardRadius,
            child: Stack(
              children: [
                Positioned.fill(
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: bgImage,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.p_12,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FinfulImage(
                            type: FinfulImageType.asset,
                            source: image,
                            width: Dimens.p_44,
                            height: Dimens.p_44,
                          ),
                          const SizedBox(height: Dimens.p_11),
                          Text(
                            content,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              height: Dimens.p_17/ Dimens.p_14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: Dimens.p_18),
                          Container(
                            decoration: BoxDecoration(
                              color: FinfulColor.bgOpacity25,
                              borderRadius: BorderRadius.all(Radius.circular(Dimens.p_5)),
                              border: Border.all(
                                width: Dimens.p_1,
                                color: FinfulColor.white,
                                style: BorderStyle.solid,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Dimens.p_10,
                              horizontal: Dimens.p_15,
                            ),
                            child: Text(
                              _statusTxt(context),
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                height: Dimens.p_14/ Dimens.p_12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
