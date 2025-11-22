import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/domain/model/section_model.dart';
import 'package:finful_app/app/presentation/journey/dashboard/dashboard_router.dart';
import 'package:finful_app/app/presentation/journey/section/spending/section_spending_qa_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

enum SectionSpendingEntryFrom { familySupport, dashboard }

abstract interface class ISectionSpendingRouter {
  void gotoQA();

  void goBackDashboard();
}

class SectionSpendingRouter extends BaseRouter implements ISectionSpendingRouter {
  SectionSpendingRouter({
    required this.entryFrom,
    required this.planId,
    required this.familySupportAnswersFilled,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final SectionSpendingEntryFrom entryFrom;
  final String planId;
  final List<SectionAnswerModel> familySupportAnswersFilled;

  @override
  void gotoQA() {
    final router = SectionSpendingQARouter(
      planId: planId,
      familySupportAnswersFilled: familySupportAnswersFilled,
    );
    router.start();
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionSpending, router: this);
  }

  @override
  void goBackDashboard() {
    final router = DashboardRouter();
    router.startAndRemoveUntil(null);
  }
}