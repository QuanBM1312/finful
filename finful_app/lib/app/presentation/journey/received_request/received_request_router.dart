import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/dashboard/dashboard_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

enum ReceivedRequestType { chatExpert, bookingExpert }

abstract interface class IReceivedRequestRouter {
  void goBackDashboard();
}

class ReceivedRequestRouter extends BaseRouter implements IReceivedRequestRouter {
  ReceivedRequestRouter({
    required this.type,
  }) : super(navigatorKey: AppRoutes.shared.navigatorKey);

  final ReceivedRequestType type;

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.receivedRequest, router: this);
  }

  @override
  void goBackDashboard() {
    final router = DashboardRouter();
    router.startAndRemoveUntil(null);
  }
}