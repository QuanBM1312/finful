
import 'package:finful_app/core/constant/model_constant.dart';

class CreatePlanResponse {
  final String? planId;

  CreatePlanResponse({
    this.planId,
  });

  factory CreatePlanResponse.fromJson(Map<String, dynamic> json) {
    return CreatePlanResponse(
      planId: json['planId'] ?? kString,
    );
  }
}