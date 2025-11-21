
import 'package:finful_app/app/data/model/user.dart';

abstract interface class UserInteractor {
  User? getLoggedInUserFromLocal();

  Future<void> saveLoggedInUserToLocal(User currentUser);

  Future<User?> getLoggedInUser({
    required bool forceToUpdate,
    required String? userId,
  });
}