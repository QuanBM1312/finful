import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/domain/model/extension/extension.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/presentation/widgets/section/section_progress_bar.dart';
import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/context_extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: Dimens.p_15,
        horizontal: Dimens.p_10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: FinfulColor.textSetting,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: FinfulColor.textW,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimens.p_1,
      color: FinfulColor.white.withValues(alpha: 0.3),
    );
  }
}

class AccountTab extends StatelessWidget {
  const AccountTab({
    super.key,
    required this.onSettingPressed,
  });

  final VoidCallback onSettingPressed;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: Dimens.p_3,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          titleSpacing: FinfulDimens.zero,
          title: BlocBuilder<SessionBloc, SessionState>(
            builder: (_, state) {
              final titleText = state.loggedInUser?.toFullName
                  ?? L10n.of(context)
                      .translate('common_dummy_name');
              return Text(
                titleText,
                textAlign: TextAlign.center,
              );
            },
          ),
          titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            height: Dimens.p_14 / Dimens.p_16,
          ),
          actions: [
            InkWell(
              onTap: onSettingPressed,
              child: SizedBox(
                width: Dimens.p_32,
                height: Dimens.p_32,
                child: Center(
                  child: FinfulImage(
                    type: FinfulImageType.asset,
                    source: ImageConstants.imgSettings,
                    width: Dimens.p_24,
                    height: Dimens.p_24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: Dimens.p_18),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            height: Dimens.p_3,
            color: FinfulColor.disabled,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: Dimens.p_20,
            right: Dimens.p_20,
            top: Dimens.p_20,
          ),
          sliver: SliverToBoxAdapter(
            child: BlocBuilder<SessionBloc, SessionState>(
              builder: (_, state) {
                final fullNameTxt = state.loggedInUser?.toFullName
                    ?? L10n.of(context)
                        .translate('common_dummy_name');

                return Column(
                  children: [
                    FinfulImage(
                      type: FinfulImageType.asset,
                      source: ImageConstants.imgDefaultCard,
                      borderRadius: BorderRadius.circular(Dimens.p_60),
                      width: Dimens.p_120,
                      height: Dimens.p_120,
                    ),
                    const SizedBox(height: Dimens.p_20),
                    Text(
                      fullNameTxt,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: Dimens.p_20,
                        height: Dimens.p_14 / Dimens.p_20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: Dimens.p_20,
            right: Dimens.p_20,
            top: Dimens.p_36,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TỶ LỆ HOÀN THÀNH CUNG CẤP THÔNG TIN: 65%",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: FinfulColor.textSetting,
                    height: Dimens.p_14 / Dimens.p_12,
                  ),
                ),
                const SizedBox(height: Dimens.p_16),
                SectionProgressBar(
                  current: 6,
                  total: 10,
                  borderRadius: BorderRadius.circular(Dimens.p_3),
                  foregroundColor: FinfulColor.white,
                )
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            left: Dimens.p_20,
            right: Dimens.p_20,
            top: Dimens.p_30,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: FinfulColor.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.p_10,
                    vertical: Dimens.p_16,
                  ),
                  child: Text(
                    L10n.of(context)
                        .translate('account_tab_summary'),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: FinfulColor.black12,
                      height: Dimens.p_14 / Dimens.p_18,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FinfulColor.white.withValues(alpha: 0.3),
                      width: Dimens.p_1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title1'),
                        value: "2027",
                      ),
                      _Divider(),
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title2'),
                        value: "2027",
                      ),
                      _Divider(),
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title3'),
                        value: "2027",
                      ),
                      _Divider(),
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title4'),
                        value: "2027",
                      ),
                      _Divider(),
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title5'),
                        value: "2027",
                      ),
                      _Divider(),
                      _SummaryTile(
                        label: L10n.of(context)
                            .translate('account_tab_summary_title6'),
                        value: "2027",
                      ),
                    ],
                  ),
                )
              ],
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
