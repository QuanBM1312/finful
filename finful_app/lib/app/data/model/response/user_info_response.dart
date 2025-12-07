import 'package:finful_app/core/constant/model_constant.dart';

class UserInfoResponse {
  final bool? success;
  final String? userId;
  final String? email;
  final String? firstName;
  final String? lastName;

  UserInfoResponse({
    this.success,
    this.userId,
    this.email,
    this.firstName,
    this.lastName
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      success: json['success'],
      userId: json['userId'] ?? kString,
      email: json['email'] ?? kString,
      firstName: json['firstName'] ?? kString,
      lastName: json['lastName'] ?? kString,
    );
  }
}