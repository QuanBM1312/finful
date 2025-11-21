
import 'package:finful_app/core/constant/model_constant.dart';

class LogoutResponse {
  final bool? success;
  final String? message;

  LogoutResponse({
    this.success,
    this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? kString,
    );
  }
}