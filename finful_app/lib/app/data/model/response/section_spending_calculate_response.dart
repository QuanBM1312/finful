
import 'package:finful_app/core/constant/model_constant.dart';
import 'package:finful_app/core/entity/entity.dart';

class SectionProjectionDataResponse extends BaseEntity {
  final int? year;
  final int? age;
  final bool? isAffordable;
  final int? affordabilityShortfall;

  SectionProjectionDataResponse({
    this.year,
    this.age,
    this.isAffordable,
    this.affordabilityShortfall,
  });

  factory SectionProjectionDataResponse.fromJson(Map<String, dynamic> json) {
    return SectionProjectionDataResponse(
      year: json['year'] ?? kInt,
      age: json['age'] ?? kInt,
      isAffordable: json['isAffordable'] ?? false,
      affordabilityShortfall: json['affordabilityShortfall'] ?? kInt,
    );
  }

  @override
  List<Object?> get props => [
    year,
    age,
    isAffordable,
    affordabilityShortfall,
  ];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}

class SectionSpendingCalculateResponse extends BaseEntity {
  final bool? success;
  final bool? isAffordable;
  final int? affordableYear;
  final String? message;
  final List<SectionProjectionDataResponse>? projectionData;

  SectionSpendingCalculateResponse({
    this.success,
    this.isAffordable,
    this.affordableYear,
    this.message,
    this.projectionData,
  });

  factory SectionSpendingCalculateResponse.fromJson(Map<String, dynamic> json) {
    final jsonProjectionData = json['projectionData'];
    final mapJsonProjectionData = jsonProjectionData != null &&
        jsonProjectionData is List &&
        jsonProjectionData.isNotEmpty
        ? List<Map<String, dynamic>>.from(jsonProjectionData)
        : null;
    final projectionData = mapJsonProjectionData?.map(SectionProjectionDataResponse.fromJson)
        .toList();
    return SectionSpendingCalculateResponse(
      success: json['success'] ?? false,
      isAffordable: json['isAffordable'] ?? false,
      affordableYear: json['affordableYear'] ?? kInt,
      projectionData: projectionData,
      message: json['message'] ?? kString,
    );
  }

  @override
  List<Object?> get props => [
    isAffordable,
    affordableYear,
    projectionData,
    message,
  ];

  @override
  Map<String, dynamic>? toJson() {
    return null;
  }
}