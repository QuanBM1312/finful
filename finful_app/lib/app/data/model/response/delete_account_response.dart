import 'package:finful_app/core/constant/model_constant.dart';

class DeleteAccountResponse {
  final bool? success;
  final String? message;

  DeleteAccountResponse({
    this.success,
    this.message,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? kString,
    );
  }
}