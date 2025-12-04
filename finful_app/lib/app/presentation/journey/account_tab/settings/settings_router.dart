import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

abstract interface class ISettingsRouter {

}

class SettingsRouter extends BaseRouter implements ISettingsRouter {
  SettingsRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.settings, router: this);
  }

}