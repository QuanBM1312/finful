import 'package:finful_app/app/constants/images.dart';
import 'package:finful_app/app/domain/model/extension/user_ext.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_bloc.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_state.dart';
import 'package:finful_app/app/presentation/widgets/app_image/FinfulImage.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:finful_app/core/extension/string_extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoHeaderView extends StatelessWidget {
  const InfoHeaderView({super.key});

  String greetingTxt(BuildContext context, SessionState state) {
    final greetingTxt = L10n.of(context).translate('dashboard_greeting');
    final dummyName = L10n.of(context).translate('common_dummy_name');
    final loggedInUser = state.loggedInUser;
    final fullName = loggedInUser != null ? loggedInUser.toFullName : dummyName;
    return "$greetingTxt, $fullName!";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (_, state) {
        final imageUrl = state.loggedInUser?.imageUrl;
        final avatar = imageUrl.isNotNullAndEmpty ?
        imageUrl : ImageConstants.imgDefaultAvatar;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                greetingTxt(context, state),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  height: Dimens.p_14/ Dimens.p_16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(width: Dimens.p_40),
            FinfulImage(
              type: FinfulImageType.asset,
              source: avatar,
              borderRadius: BorderRadius.circular(Dimens.p_20),
              width: Dimens.p_40,
              height: Dimens.p_40,
            ),
          ],
        );
      },
    );
  }
}