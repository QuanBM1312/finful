import 'package:collection/collection.dart';

import 'analytics_event.dart';
import 'analytics_service.dart';

abstract class AnalyticsManagerProtocol {
  void addAnalyticsService(AnalyticsService service);
  void clearAnalyticsService();
}

class AnalyticsManager extends AnalyticsService
    implements AnalyticsManagerProtocol {
  final List<AnalyticsService> _services = [];

  @override
  void addAnalyticsService(AnalyticsService service) {
    _services.add(service);
  }

  @override
  void clearAnalyticsService() {
    _services.clear();
  }

  @override
  Future<void> initialize() async {
    assert(_services.isNotEmpty, 'services must be added before initialize');
    for (final service in _services) {
      await service.initialize();
    }
  }

  @override
  Future<void> setUserId(String? userId) async {
    for (final service in _services) {
      await service.setUserId(userId);
    }
  }

  @override
  bool canHandle<E extends AnalyticsEvent>(E event) {
    final service =
    _services.firstWhereOrNull((element) => element.canHandle(event));
    return service != null;
  }

  @override
  Future<void> logEvent<E extends AnalyticsEvent>(E event) async {
    for (final service in _services) {
      if (service.canHandle(event)) {
        await service.logEvent(event);
      }
    }
  }
}
