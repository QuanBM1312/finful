

import '../../../core/presentation/base_router.dart';
import '../../constants/route.dart';
import '../../routes/app_routes.dart';

abstract interface class IDevModeRouter {

}

class DevModeRouter extends BaseRouter implements IDevModeRouter {
  DevModeRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.devMode, router: this);
  }

}
