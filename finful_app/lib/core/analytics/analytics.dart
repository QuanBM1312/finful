import 'analytics_manager.dart';
export 'analytics_manager.dart';
export 'analytics_event.dart';
export 'analytics_service.dart';

class XHRAnalytics extends AnalyticsManager {
  static final XHRAnalytics _instance = XHRAnalytics._();

  factory XHRAnalytics() {
    return _instance;
  }

  static XHRAnalytics get shared => _instance;

  XHRAnalytics._();
}
