import 'package:finful_app/app/constants/constants.dart';
import 'package:finful_app/app/data/enum/section.dart';
import 'package:finful_app/app/presentation/blocs/get_section_progress/get_section_progress.dart';
import 'package:finful_app/app/presentation/journey/dashboard/ui_model/section_dashboard_item.dart';
import 'package:finful_app/app/presentation/journey/dashboard/widgets/dashboard_static_schedule.dart';
import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/info_header_view.dart';
import 'widgets/info_section_item_loading.dart';
import 'widgets/info_section_item_view.dart';
import 'widgets/info_subheader_view.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
    required this.sectionItems,
    required this.onStaticSchedulePressed,
    required this.onSectionItemPressed,
  });

  final List<SectionDashboardItem> sectionItems;
  final VoidCallback onStaticSchedulePressed;
  final Function(SectionDashboardItem item) onSectionItemPressed;

  String _bgImage(SectionDashboardItem item) {
    switch (item.sectionType) {
      case SectionType.onboarding:
        return ImageConstants.imgOnboardingBg;
      case SectionType.familySupport:
        return ImageConstants.imgFamilySupportBg;
      case SectionType.spending:
        return ImageConstants.imgSpendingBg;
      case SectionType.assumptions:
        return ImageConstants.imgAssumptionsBg;
      default:
        return ImageConstants.imgOnboardingBg;
    }
  }

  String _image(SectionDashboardItem item) {
    switch (item.sectionType) {
      case SectionType.onboarding:
        return ImageConstants.imgDashboardOnboarding;
      case SectionType.familySupport:
        return ImageConstants.imgFamilySupport;
      case SectionType.spending:
        return ImageConstants.imgDashboardSpending;
      case SectionType.assumptions:
        return ImageConstants.imgAssumptions;
      default:
        return ImageConstants.imgDashboardOnboarding;
    }
  }

  String _contentText(BuildContext context, SectionDashboardItem item) {
    switch (item.sectionType) {
      case SectionType.onboarding:
        return L10n.of(context).translate('dashboard_section_onboarding_item_content');
      case SectionType.familySupport:
        return L10n.of(context).translate('dashboard_section_familySupport_item_content');
      case SectionType.spending:
        return L10n.of(context).translate('dashboard_section_spending_item_content');
      case SectionType.assumptions:
        return L10n.of(context).translate('dashboard_section_assumptions_item_content');
      default:
        return L10n.of(context).translate('dashboard_section_onboarding_item_content');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: Dimens.p_14 + context.queryPaddingTop,
            left: FinfulDimens.md,
            right: FinfulDimens.md,
          ),
          sliver: SliverToBoxAdapter(
            child: const InfoHeaderView(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: FinfulDimens.md,
            right: FinfulDimens.md,
          ),
          sliver: SliverToBoxAdapter(
            child: const InfoSubHeaderView(),
          ),
        ),
        SliverToBoxAdapter(
          child: const SizedBox(height: Dimens.p_40),
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: FinfulDimens.md,
            ),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Dimens.p_12,
              crossAxisSpacing: Dimens.p_12,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final itemData = sectionItems[index];
              return BlocBuilder<GetSectionProgressBloc, GetSectionProgressState>(
                builder: (_, state) {
                  if (state is GetSectionProgressGetCurrentInProgress) {
                    return const InfoSectionItemLoading();
                  }

                  if (state.currentProgress != null) {
                    return InfoSectionItemView(
                      isCompleted: itemData.isCompleted,
                      isActivated: itemData.isActivated,
                      bgImage: _bgImage(itemData),
                      image: _image(itemData),
                      content: _contentText(context, itemData),
                      onPressed: () => onSectionItemPressed(itemData),
                    );
                  }

                  return const InfoSectionItemLoading();
                },
              );
            },
              childCount: sectionItems.length,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: Dimens.p_40,
            left: FinfulDimens.md,
            right: FinfulDimens.md,
          ),
          sliver: SliverToBoxAdapter(
            child: DashboardStaticSchedule(
              onPressed: onStaticSchedulePressed,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Dimens.p_40 + context.queryPaddingBottom,
          ),
        ),
      ],
    );
  }
}
