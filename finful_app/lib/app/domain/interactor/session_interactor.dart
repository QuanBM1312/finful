
import 'package:finful_app/core/datasource/config.dart';

abstract interface class SessionInteractor {
  Authorization? getLoggedInAuthorization();

  Future<void> clearSessionDataAtLocal();
}