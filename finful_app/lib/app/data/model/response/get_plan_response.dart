import 'package:finful_app/core/constant/model_constant.dart';

class GetPlanResponse {
  final String? id;
  final String? userId;
  final String? planName;

  GetPlanResponse({
    this.id,
    this.userId,
    this.planName,
  });

  factory GetPlanResponse.fromJson(Map<String, dynamic> json) {
    return GetPlanResponse(
      id: json['id'] ?? kString,
      userId: json['userId'] ?? kString,
      planName: json['planName'] ?? kString,
    );
  }
}