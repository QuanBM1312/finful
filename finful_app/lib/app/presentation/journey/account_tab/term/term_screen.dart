import 'package:finful_app/app/constants/icons.dart';
import 'package:finful_app/app/presentation/journey/account_tab/term/term_router.dart';
import 'package:finful_app/app/theme/colors.dart';
import 'package:finful_app/app/theme/dimens.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/common/widgets/app_bar/finful_app_bar.dart';
import 'package:finful_app/common/widgets/app_icon/app_icon.dart';
import 'package:finful_app/core/presentation/base_screen_mixin.dart';
import 'package:flutter/material.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen>
    with BaseScreenMixin<TermScreen, TermRouter> {

  void _onBackPressed() {
    router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: FinfulAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        forceMaterialTransparency: true,
        title: "",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.p_22,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: Dimens.p_40),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Điều khoản sử dụng",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: Dimens.p_25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimens.p_20),
                  Text(
                    "Heading của nội dung 1",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: Dimens.p_16),
                  Text(
                    "Trong Điều khoản này, thuật ngữ “xử lý dữ liệu cá nhân” được hiểu là một hoặc nhiều hoạt động tác động tới dữ liệu cá nhân, như: thu thập, ghi, phân tích, xác nhận, lưu trữ, chỉnh sửa, công khai, kết hợp, truy nhập, truy xuất, thu hồi, mã hoá, giải mã, sao chép , chia sẻ, truyền đưa, cung cấp, chuyển giao, xoá, huỷ dữ liệu cá nhân hoặc các hành động khác có liên quan. ",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: FinfulColor.textW.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
