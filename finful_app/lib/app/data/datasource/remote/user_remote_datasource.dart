import 'package:finful_app/app/data/model/response/delete_account_response.dart';
import 'package:finful_app/app/data/model/response/user_extra_info_response.dart';
import 'package:finful_app/app/data/model/response/user_info_response.dart';

abstract interface class UserRemoteDatasource {
  Future<UserInfoResponse> getCurrentUserInfo();

  Future<UserExtInfoResponse> getCurrentUserExtraInfo();

  Future<DeleteAccountResponse> postDeleteAccount();
}