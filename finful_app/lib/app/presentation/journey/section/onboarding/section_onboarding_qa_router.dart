import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/authentication/signup_intro_router.dart';
import 'package:finful_app/app/presentation/journey/dashboard/dashboard_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

import 'section_onboarding_screen.dart';

abstract interface class ISectionOnboardingQARouter {
  void gotoSignUpIntro();

  void goBackDashboard();
}

class SectionOnboardingQARouter extends BaseRouter implements ISectionOnboardingQARouter {
  SectionOnboardingQARouter({
    required this.entryFrom,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final SectionOnboardingEntryFrom entryFrom;

  @override
  void gotoSignUpIntro() {
    final router = SignUpIntroRouter();
    router.start();
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionOnboardingQA, router: this);
  }

  @override
  void goBackDashboard() {
    final router = DashboardRouter();
    router.startAndRemoveUntil(null);
  }
}