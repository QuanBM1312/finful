
import 'package:finful_app/core/datasource/config.dart';

abstract interface class AuthLocalDatasource {
  Future<void> saveAuthorization(Authorization authorization);

  Authorization? loadAuthorization();

  Future<void> clearAuthorization();
}
