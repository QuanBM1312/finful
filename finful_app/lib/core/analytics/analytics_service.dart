import 'analytics_event.dart';

abstract class AnalyticsService {
  Future<void> initialize();

  Future<void> setUserId(String? userId);

  bool canHandle<E extends AnalyticsEvent>(E event);

  Future<void> logEvent<E extends AnalyticsEvent>(E event);
}
