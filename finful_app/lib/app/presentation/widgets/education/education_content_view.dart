import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/app/theme/dimens.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/extension.dart';
import 'package:finful_app/core/mixin/widget_didmount_mixin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EducationContentView extends StatefulWidget {
  const EducationContentView({
    super.key,
    this.showDivider = false,
    required this.title,
    required this.description,
    required this.url,
  });

  final bool showDivider;
  final String? title;
  final String? description;
  final String? url;

  @override
  State<EducationContentView> createState() => _EducationContentViewState();
}

class _EducationContentViewState extends State<EducationContentView>
    with TickerProviderStateMixin, WidgetDidMount<EducationContentView> {
  late final Future<LottieComposition> _composition;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _composition = NetworkLottie(
      widget.url ?? "",
      decoder: LottieComposition.decodeGZip,
      backgroundLoading: true,
    ).load();
  }

  @override
  void widgetDidMount(BuildContext context) {

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: FinfulDimens.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showDivider) Container(
            decoration: BoxDecoration(
              color: FinfulColor.divider,
            ),
            width: double.infinity,
            height: Dimens.p_3,
            margin: EdgeInsets.only(
              bottom: Dimens.p_23,
            ),
          ) else const SizedBox(),
          if (widget.title.isNotNullAndEmpty)
            Padding(
              padding: EdgeInsets.only(
                bottom: Dimens.p_14,
              ),
              child: Row(
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
                      widget.title!,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: FinfulColor.brandPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ) else const SizedBox(),
          if (widget.description.isNotNullAndEmpty)
            Text(
              widget.description!,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                height: Dimens.p_23 / Dimens.p_16,
                fontWeight: FontWeight.w400,
              ),
            ) else const SizedBox(),
          const SizedBox(height: Dimens.p_60),
          FutureBuilder<LottieComposition>(
            future: _composition,
            builder: (_, snapshot) {
              final composition = snapshot.data;
              if (composition != null) {
                return SizedBox(
                  width: context.queryWidth,
                  height: context.queryWidth * 1.3,
                  child: Lottie(
                    controller: _controller,
                    composition: composition,
                    frameRate: FrameRate.composition,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    animate: true,
                  ),
                );
              }

              return Center(
                child: SizedBox(
                  width: Dimens.p_60,
                  height: Dimens.p_60,
                  child: CircularProgressIndicator(
                    color: FinfulColor.brandPrimary,
                    backgroundColor: FinfulColor.brandPrimary.withValues(alpha: 0.30),
                    strokeWidth: Dimens.p_8,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
