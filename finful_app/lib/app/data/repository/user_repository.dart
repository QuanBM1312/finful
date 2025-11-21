
import 'package:finful_app/app/data/model/user.dart';

abstract interface class UserRepository {
  Future<void> saveUserToLocal({
    required User user,
  });

  User? getLoggedInUserFromLocal();

  Future<void> clearUserAtLocal();

  Future<User?> getLoggedInUser({
    required bool forceToUpdate,
    required String? userId,
  });
}