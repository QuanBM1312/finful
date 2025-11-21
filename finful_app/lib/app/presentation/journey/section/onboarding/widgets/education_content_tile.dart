
import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';

class EducationContentTile extends StatelessWidget {
  const EducationContentTile({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimens.p_30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FinfulImage(
                type: FinfulImageType.asset,
                source: ImageConstants.imgQuestionMark,
                width: Dimens.p_14,
                height: Dimens.p_14,
              ),
              const SizedBox(width: Dimens.p_6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: FinfulColor.brandPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.p_6),
          Text(
            description,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: FinfulColor.textWOpacity80,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
