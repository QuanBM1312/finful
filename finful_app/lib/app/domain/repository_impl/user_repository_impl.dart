import 'package:finful_app/app/data/datasource/local/user_local_datasource.dart';
import 'package:finful_app/app/data/datasource/remote/user_remote_datasource.dart';
import 'package:finful_app/app/data/model/response/delete_account_response.dart';
import 'package:finful_app/app/data/model/response/user_extra_info_response.dart';
import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/app/data/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  late final UserLocalDatasource _userLocalDatasource;
  late final UserRemoteDatasource _userRemoteDatasource;

  UserRepositoryImpl({
    required UserLocalDatasource userLocalDatasource,
    required UserRemoteDatasource userRemoteDatasource,
  })  : _userLocalDatasource = userLocalDatasource,
        _userRemoteDatasource = userRemoteDatasource;

  @override
  Future<void> clearUserAtLocal() async {
    await _userLocalDatasource.clearUser();
  }

  @override
  Future<User?> getLoggedInUser({
    required bool forceToUpdate,
    required String? userId
  }) async {
    final loggedInUser = _userLocalDatasource.loadUser();

    if (forceToUpdate && userId != null) {
      final response = await _userRemoteDatasource.getCurrentUserInfo();
      final currentUserInfo = User(
          userId: response.userId,
          email: response.email,
          firstName: response.firstName,
          lastName: response.lastName
      );
      return currentUserInfo;
    }

    return loggedInUser;
  }

  @override
  User? getLoggedInUserFromLocal() {
    return _userLocalDatasource.loadUser();
  }

  @override
  Future<void> saveUserToLocal({
    required User user
  }) async {
    await _userLocalDatasource.saveUser(user);
  }

  @override
  Future<UserExtInfoResponse> getCurrentUserExtraInfo() async {
    final response = await _userRemoteDatasource.getCurrentUserExtraInfo();
    return response;
  }

  @override
  Future<DeleteAccountResponse> deleteAccount() async {
    return await _userRemoteDatasource.postDeleteAccount();
  }
}