import 'package:finful_app/app/constants/constants.dart';
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/data/enum/section.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_bloc.dart';
import 'package:finful_app/app/presentation/blocs/common/session/session_state.dart';
import 'package:finful_app/app/presentation/blocs/get_plan/get_plan.dart';
import 'package:finful_app/app/presentation/blocs/mixins/get_plan_bloc_mixin.dart';
import 'package:finful_app/app/presentation/blocs/mixins/session_bloc_mixin.dart';
import 'package:finful_app/app/presentation/journey/dashboard/dashboard_router.dart';
import 'package:finful_app/app/presentation/journey/dashboard/widgets/dashboard_none_final_plan_content.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';
import 'package:finful_app/core/extension/extension.dart';
import 'package:finful_app/core/localization/l10n.dart';
import 'package:finful_app/core/presentation/base_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui_model/section_dashboard_item.dart';

class _TabBarItem {
  final String icon;
  final String activeIcon;
  final String label;

  _TabBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with BaseScreenMixin<DashboardScreen, DashboardRouter>,
        SessionBlocMixin, GetPlanBlocMixin {
  int _currentTabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  bool _isFinalPlan = false;
  bool _isSpendingFlowActivated = false;
  List<SectionDashboardItem> _sectionItems = [];

  List<SectionDashboardItem> get _defaultInitSectionItems {
    return [
      SectionDashboardItem(
        isCompleted: false,
        isActivated: true,
        bgImage: ImageConstants.imgOnboardingBg,
        image: ImageConstants.imgDashboardOnboarding,
        content: L10n.of(context).translate('dashboard_section_onboarding_item_content'),
        sectionType: SectionType.onboarding,
      ),
      SectionDashboardItem(
        isCompleted: false,
        isActivated: true,
        bgImage: ImageConstants.imgFamilySupportBg,
        image: ImageConstants.imgFamilySupport,
        content: L10n.of(context).translate('dashboard_section_familySupport_item_content'),
        sectionType: SectionType.familySupport,
      ),
      SectionDashboardItem(
        isCompleted: false,
        isActivated: true,
        bgImage: ImageConstants.imgSpendingBg,
        image: ImageConstants.imgDashboardSpending,
        content: L10n.of(context).translate('dashboard_section_spending_item_content'),
        sectionType: SectionType.spending,
      ),
      SectionDashboardItem(
        isCompleted: false,
        isActivated: true,
        bgImage: ImageConstants.imgAssumptionsBg,
        image: ImageConstants.imgAssumptions,
        content: L10n.of(context).translate('dashboard_section_assumptions_item_content'),
        sectionType: SectionType.assumptions,
      ),
    ];
  }

  @override
  void didMountWidget() {
    super.didMountWidget();
    setState(() {
      _sectionItems = _defaultInitSectionItems;
    });
    final sessionState = getSessionState;
    final loggedInUser = sessionState.loggedInUser;
    if (loggedInUser != null) {
      BlocManager().event<GetPlanBloc>(
        BlocConstants.getPlan,
        GetPlanGetCurrentPlanStarted(),
      );
    }
  }

  void _processGetCurrentPlanSuccess(GetPlanGetCurrentPlanSuccess state) {
    final currentPlan = state.currentPlan;
    final shouldSpendingFlowEnabled = currentPlan != null &&
        currentPlan.planId.isNotNullAndEmpty;
    if (shouldSpendingFlowEnabled) {
      final spendingItem = _sectionItems.firstWhere((e) => e.sectionType == SectionType.spending);
      final newSpendingItem = SectionDashboardItem(
        isCompleted: spendingItem.isCompleted,
        isActivated: shouldSpendingFlowEnabled,
        bgImage: spendingItem.bgImage,
        image: spendingItem.image,
        content: spendingItem.content,
        sectionType: spendingItem.sectionType,
      );
      final tempItems = _sectionItems.where((e) => e.sectionType != spendingItem.sectionType).toList();
      tempItems.add(newSpendingItem);
      tempItems.toList();
      setState(() {
        _sectionItems = tempItems;
      });

      if (shouldSpendingFlowEnabled != _isSpendingFlowActivated) {
        setState(() {
          _isSpendingFlowActivated = shouldSpendingFlowEnabled;
        });
      }
    }
  }

  void _onSectionItemPressed(SectionDashboardItem item) {
    switch (item.sectionType) {
      case SectionType.spending:
        final planState = getPlanState;
        final currentPlan = planState.currentPlan;
        if (currentPlan != null && currentPlan.planId.isNotNullAndEmpty) {
          router.gotoSpending(
            planId: currentPlan.planId!,
          );
        }
        break;
      case SectionType.assumptions:
        final planState = getPlanState;
        final currentPlan = planState.currentPlan;
        router.gotoAssumptions(
          planId: "mock",
        );
      default:
    }
  }

  void _onStaticSchedulePressed() {

  }

  void _sessionBlocListener(BuildContext context, SessionState state) {
    switch (state.runtimeType) {
      case SessionForceUserSignInSuccess:
        router.replaceWithSignIn();
        break;
      default:
    }
  }

  void _getPlanBlocListener(BuildContext context, GetPlanState state) {
    switch (state.runtimeType) {
      case GetPlanGetCurrentPlanSuccess:
        _processGetCurrentPlanSuccess(state as GetPlanGetCurrentPlanSuccess);
        break;
      default:
    }
  }

  List<BlocListener> get _mapToBlocListeners {
    return [
      BlocListener<SessionBloc, SessionState>(
        listener: _sessionBlocListener,
      ),
      BlocListener<GetPlanBloc, GetPlanState>(
        listener: _getPlanBlocListener,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: _mapToBlocListeners,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        drawerEdgeDragWidth: 0.0,
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
        body: !_isFinalPlan ?
        DashboardNoneFinalPlanContent(
          sectionItems: _sectionItems,
          onSectionItemPressed: _onSectionItemPressed,
          onStaticSchedulePressed: _onStaticSchedulePressed,
        ) : Container(),
      ),
    );
  }
}




