import 'package:finful_app/app/data/model/user.dart';

abstract interface class UserLocalDatasource {
  Future<void> saveUser(User user);

  User? loadUser();

  Future<void> clearUser();
}