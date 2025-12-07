import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/app/domain/model/user_ext_model.dart';

abstract interface class UserInteractor {
  User? getLoggedInUserFromLocal();

  Future<void> saveLoggedInUserToLocal(User currentUser);

  Future<User?> getLoggedInUser({
    required bool forceToUpdate,
    required String? userId,
  });

  Future<UserExtModel> getCurrentUserExtraInfo();

  Future<bool> submitDeleteAccount();
}