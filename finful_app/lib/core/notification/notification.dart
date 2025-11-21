export 'notification_manager.dart';
export 'notification_service.dart';
import 'notification_manager.dart';

class XHRNotification extends NotificationManager {
  static final XHRNotification _instance = XHRNotification._();

  factory XHRNotification() {
    return _instance;
  }

  static XHRNotification get shared => _instance;

  XHRNotification._();
}
