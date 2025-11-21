
import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

import 'section_assumptions_qa_router.dart';

abstract interface class ISectionAssumptionsRouter {
  void gotoQA();
}

class SectionAssumptionsRouter extends BaseRouter implements ISectionAssumptionsRouter {
  SectionAssumptionsRouter({
    required this.planId,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final String planId;

  @override
  void gotoQA() {
    final router = SectionAssumptionsQARouter(
      planId: planId,
    );
    router.start();
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionAssumptions, router: this);
  }

}