import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

abstract interface class IPolicyRouter {

}

class PolicyRouter extends BaseRouter implements IPolicyRouter {
  PolicyRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.policy, router: this);
  }

}