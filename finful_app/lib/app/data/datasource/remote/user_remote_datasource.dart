
import 'package:finful_app/app/data/model/response/user_info_response.dart';

abstract interface class UserRemoteDatasource {
  Future<UserInfoResponse> getCurrentUserInfo();
}