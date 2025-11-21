import 'package:finful_app/core/constant/model_constant.dart';

class SignInResponse {
  final String? userId;
  final String? token;

  SignInResponse({
    this.userId,
    this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      userId: json['userId'] ?? kString,
      token: json['token'] ?? kString,
    );
  }
}