import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/account_tab/policy/policy_router.dart';
import 'package:finful_app/app/presentation/journey/account_tab/term/term_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

abstract interface class ISettingsRouter {
  void gotoPolicy();

  void gotoTerm();
}

class SettingsRouter extends BaseRouter implements ISettingsRouter {
  SettingsRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.settings, router: this);
  }

  @override
  void gotoPolicy() {
    final router = PolicyRouter();
    router.start();
  }

  @override
  void gotoTerm() {
    final router = TermRouter();
    router.start();
  }
}