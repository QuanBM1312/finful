import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/section/family_support/section_family_support_qa_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

abstract interface class ISectionFamilySupportRouter {
  void gotoQA();
}

class SectionFamilySupportRouter extends BaseRouter implements ISectionFamilySupportRouter {
  SectionFamilySupportRouter({
    required this.planId,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final String planId;

  @override
  void gotoQA() {
    final router = SectionFamilySupportQARouter(
      planId: planId,
    );
    router.start();
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.sectionFamilySupport, router: this);
  }

}