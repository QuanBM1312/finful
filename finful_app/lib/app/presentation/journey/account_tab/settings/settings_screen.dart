import 'package:finful_app/app/constants/icons.dart';
import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/domain/model/extension/user_ext.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session.dart';
import 'package:finful_app/app/presentation/journey/account_tab/settings/settings_router.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/app/theme/dimens.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/common/widgets/app_bar/finful_app_bar.dart';
import 'package:finful_app/common/widgets/app_icon/app_icon.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:finful_app/core/extension/extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:finful_app/core/presentation/base_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _ContentWrapper extends StatelessWidget {
  const _ContentWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FinfulColor.cardBg,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.p_8)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Dimens.p_15,
        horizontal: Dimens.p_10,
      ),
      child: child,
    );
  }
}

class _ContentTile extends StatelessWidget {
  const _ContentTile({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.queryWidth * 0.23,
          child: Text(
            label,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: FinfulColor.textSetting,
              fontSize: Dimens.p_15,
              height: Dimens.p_14 / Dimens.p_15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: Dimens.p_24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: FinfulColor.textW,
                  fontSize: Dimens.p_17,
                  height: Dimens.p_14 / Dimens.p_17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: Dimens.p_8),
              _Divider(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentFormHeader extends StatelessWidget {
  const _ContentFormHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: FinfulColor.textW,
            fontSize: Dimens.p_17,
            height: Dimens.p_14 / Dimens.p_17,
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    super.key,
    required this.onPressed,
    required this.title,
    this.showIcon = true,
  });

  final VoidCallback onPressed;
  final String title;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: FinfulColor.textSetting,
              fontSize: Dimens.p_15,
              height: Dimens.p_14 / Dimens.p_15,
            ),
          ),
          if (showIcon)
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: FinfulColor.white.withValues(alpha: 0.8),
              size: Dimens.p_12,
            ) else const SizedBox(),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with BaseScreenMixin<SettingsScreen, SettingsRouter> {

  void _onBackPressed() {
    router.pop();
  }

  void _onLogoutPressed() {
    BlocManager().event<SessionBloc>(
      BlocConstants.session,
      SessionUserLogOutSubmitted(),
    );
  }

  void _onPolicyPressed() {
    router.gotoPolicy();
  }

  void _onTermPressed() {
    router.gotoTerm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: FinfulAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        forceMaterialTransparency: true,
        title: L10n.of(context)
            .translate('setting_screen_header_title'),
        titleStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        leadingIcon: AppSvgIcon(
          IconConstants.icBack,
          width: FinfulDimens.iconMd,
          height: FinfulDimens.iconMd,
          color: FinfulColor.white,
        ),
        onLeadingPressed: _onBackPressed,
      ),
      body: CustomScrollView(
        slivers: [
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
              child: Center(
                child: FinfulImage(
                  type: FinfulImageType.asset,
                  source: ImageConstants.imgDefaultCard,
                  borderRadius: BorderRadius.circular(Dimens.p_60),
                  width: Dimens.p_120,
                  height: Dimens.p_120,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: Dimens.p_20,
              right: Dimens.p_20,
              top: Dimens.p_46,
            ),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<SessionBloc, SessionState>(
                builder: (_, state) {
                  final displayName = state.loggedInUser?.toFullName ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ContentFormHeader(
                        title: "Thông tin cá nhân",
                      ),
                      const SizedBox(height: Dimens.p_15),
                      _ContentWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ContentTile(
                              label: "Tên hiển thị",
                              value: displayName,
                            ),
                            const SizedBox(height: Dimens.p_16),
                            _ContentTile(
                              label: "Username",
                              value: displayName,
                            ),
                          ],
                        ),
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
              top: Dimens.p_35,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContentFormHeader(
                    title: "Thông tin chung",
                  ),
                  const SizedBox(height: Dimens.p_15),
                  _ContentWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SettingTile(
                          title: "Chính sách bảo vệ dữ liệu cá nhân",
                          onPressed: _onPolicyPressed,
                        ),
                        const SizedBox(height: Dimens.p_15),
                        _Divider(),
                        const SizedBox(height: Dimens.p_15),
                        _SettingTile(
                          title: "Điều khoản sử dụng",
                          onPressed: _onTermPressed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: Dimens.p_20,
              right: Dimens.p_20,
              top: Dimens.p_35,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContentFormHeader(
                    title: "Tài khoản",
                  ),
                  const SizedBox(height: Dimens.p_15),
                  _ContentWrapper(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SettingTile(
                          title: "Đăng xuất",
                          showIcon: false,
                          onPressed: _onLogoutPressed,
                        ),
                        const SizedBox(height: Dimens.p_15),
                        _Divider(),
                        const SizedBox(height: Dimens.p_15),
                        _SettingTile(
                          title: "Xoá tài khoản",
                          showIcon: false,
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
