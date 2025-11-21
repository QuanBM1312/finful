
import 'package:finful_app/app/data/model/response/signin_response.dart';
import 'package:finful_app/app/data/model/response/user_info_response.dart';
import 'package:finful_app/app/data/model/user.dart';
import 'package:finful_app/core/extension/string_extension.dart';

extension UserInfoResponseExt on UserInfoResponse {
  User toUser() {
    return User(
        userId: userId,
        email: email,
        firstName: firstName,
        lastName: lastName
    );
  }
}

extension UserExt on User {
  String get toFullName {
    if (firstName != null && lastName != null) {
      return "${firstName!.toCapitalized()} ${lastName!.toCapitalized()}";
    }
    if (lastName != null) {
      return lastName!.toCapitalized();
    }
    return firstName!.toCapitalized();
  }
}