import 'package:finful_app/core/constant/model_constant.dart';
import 'get_plan_response.dart';

class PatchPlanSectionResultResponse {
  final int? caseNumber;
  final String? message;
  final String? earliestPurchaseYear;
  final bool? hasWorsened;

  PatchPlanSectionResultResponse({
    this.caseNumber,
    this.message,
    this.earliestPurchaseYear,
    this.hasWorsened,
  });

  factory PatchPlanSectionResultResponse.fromJson(Map<String, dynamic> json) {
    return PatchPlanSectionResultResponse(
      caseNumber: json['caseNumber'] ?? kInt,
      message: json['message'] ?? kString,
      earliestPurchaseYear: json['earliestPurchaseYear'] ?? kString,
      hasWorsened: json['hasWorsened'] ?? false,
    );
  }
}

class PatchPlanSectionResponse {
  final bool? success;
  final GetPlanResponse? data;
  final String? section;
  final PatchPlanSectionResultResponse? result;

  PatchPlanSectionResponse({
    this.success,
    this.data,
    this.section,
    this.result,
  });

  factory PatchPlanSectionResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] != null
        ? GetPlanResponse.fromJson(json['data']) : null;
    final result = json['data'] != null
        ? PatchPlanSectionResultResponse.fromJson(json['result']) : null;

    return PatchPlanSectionResponse(
      success: json['success'] ?? false,
      data: data,
      section: json['section'] ?? kString,
      result: result,
    );
  }
}