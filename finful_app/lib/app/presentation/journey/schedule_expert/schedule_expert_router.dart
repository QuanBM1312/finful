import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/received_request/received_request_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';

abstract interface class IScheduleExpertRouter {
  void gotoChatReceivedRequest();

  void gotoBookingReceivedRequest();
}

class ScheduleExpertRouter extends BaseRouter implements IScheduleExpertRouter {
  ScheduleExpertRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  void gotoBookingReceivedRequest() {
    final router = ReceivedRequestRouter(
      type: ReceivedRequestType.bookingExpert,
    );
    router.start();
  }

  @override
  void gotoChatReceivedRequest() {
    final router = ReceivedRequestRouter(
      type: ReceivedRequestType.chatExpert,
    );
    router.start();
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.scheduleExpert, router: this);
  }

}