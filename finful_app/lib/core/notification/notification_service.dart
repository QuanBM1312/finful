abstract class NotificationService {
  Future<void> config();

  void setToken(String token);

  void clearToken();

  void onBackgroundNotification();

  void onForegroundNotification();
}
