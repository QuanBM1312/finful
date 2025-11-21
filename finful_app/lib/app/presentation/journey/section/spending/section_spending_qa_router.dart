import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/domain/model/section_model.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';
import 'package:flutter/material.dart';

abstract interface class ISectionSpendingQARouter {
  void goBackDashboard();
}

class SectionSpendingQARouter extends BaseRouter implements ISectionSpendingQARouter {
  SectionSpendingQARouter({
    required this.planId,
    required this.familySupportAnswersFilled,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final String planId;
  final List<SectionAnswerModel> familySupportAnswersFilled;

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionSpendingQA, router: this);
  }

  @override
  void goBackDashboard() {
    popUntil(ModalRoute.withName(RouteConstant.dashboard));
  }

}