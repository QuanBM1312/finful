import 'package:finful_app/core/constant/model_constant.dart';

class GetEducationResponse {
  final String? title;
  final String? message;
  final String? url;
  final int? order;

  GetEducationResponse({
    this.title,
    this.message,
    this.url,
    this.order,
  });

  factory GetEducationResponse.fromJson(Map<String, dynamic> json) {
    return GetEducationResponse(
      title: json['title'] ?? kString,
      message: json['message'] ?? kString,
      url: json['url'] ?? kString,
      order: json['order'] ?? kInt,
    );
  }
}