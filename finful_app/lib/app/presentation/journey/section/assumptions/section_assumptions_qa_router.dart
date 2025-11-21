import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';
import 'package:flutter/material.dart';

abstract interface class ISectionAssumptionsQARouter {
  void gotoScheduleRequest();

  void goBackDashboard();
}

class SectionAssumptionsQARouter extends BaseRouter implements ISectionAssumptionsQARouter {
  SectionAssumptionsQARouter({
    required this.planId,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final String planId;

  @override
  void gotoScheduleRequest() {
    // TODO: implement gotoSectionSpending
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionAssumptionsQA, router: this);
  }

  @override
  void goBackDashboard() {
    popUntil(ModalRoute.withName(RouteConstant.dashboard));
  }

}