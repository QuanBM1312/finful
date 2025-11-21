import 'notification_service.dart';

abstract class INotificationManager {
  void addNotificationService(NotificationService service);
  void clearNotificationService();
}

class NotificationManager extends NotificationService
    implements INotificationManager {
  final List<NotificationService> _services = [];

  @override
  void addNotificationService(NotificationService service) {
    _services.add(service);
  }

  @override
  void clearNotificationService() {
    _services.clear();
  }

  @override
  Future<void> config() async {
    assert(_services.isNotEmpty, 'services must be added before config');
    for (final service in _services) {
      await service.config();
    }
  }

  @override
  void setToken(String token) {
    for (final service in _services) {
      service.setToken(token);
    }
  }

  @override
  void clearToken() {
    for (final service in _services) {
      service.clearToken();
    }
  }

  @override
  void onBackgroundNotification() {
    for (final service in _services) {
      service.onBackgroundNotification();
    }
  }

  @override
  void onForegroundNotification() {
    for (final service in _services) {
      service.onForegroundNotification();
    }
  }
}
