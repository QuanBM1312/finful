import 'package:finful_app/core/constant/model_constant.dart';
import 'get_plan_response.dart';

class PatchPlanSectionResultResponse {
  final int? caseNumber;
  final String? message;
  final int? earliestPurchaseYear;
  final bool? hasWorsened;
  final String? customMessage; // assumptions
  final bool? isAffordable; // assumptions
  final bool? hasImproved; // familySupport

  PatchPlanSectionResultResponse({
    this.caseNumber,
    this.message,
    this.earliestPurchaseYear,
    this.hasWorsened,
    this.isAffordable,
    this.customMessage,
    this.hasImproved,
  });

  factory PatchPlanSectionResultResponse.fromJson(Map<String, dynamic> json) {
    return PatchPlanSectionResultResponse(
      caseNumber: json['caseNumber'] ?? kInt,
      message: json['message'] ?? kString,
      earliestPurchaseYear: json['earliestPurchaseYear'] ?? kInt,
      hasWorsened: json['hasWorsened'] ?? false,
      isAffordable: json['isAffordable'] ?? false,
      customMessage: json['customMessage'] ?? kString,
      hasImproved: json['hasImproved'] ?? false,
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