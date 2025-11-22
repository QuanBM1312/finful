import 'package:finful_app/core/constant/model_constant.dart';

class GetSectionProgressItemResponse {
  final String? state;
  final String? status;

  GetSectionProgressItemResponse({
    this.state,
    this.status,
  });

  factory GetSectionProgressItemResponse.fromJson(Map<String, dynamic> json) {
    return GetSectionProgressItemResponse(
      state: json['state'] ?? kString,
      status: json['status'] ?? kString,
    );
  }
}

class GetSectionProgressDetailResponse {
  final GetSectionProgressItemResponse? quickCheck;
  final GetSectionProgressItemResponse? familySupport;
  final GetSectionProgressItemResponse? spending;
  final GetSectionProgressItemResponse? assumption;

  GetSectionProgressDetailResponse({
    this.quickCheck,
    this.familySupport,
    this.spending,
    this.assumption,
  });

  factory GetSectionProgressDetailResponse.fromJson(Map<String, dynamic> json) {
    final quickCheck = json['quickCheck'] != null
        ? GetSectionProgressItemResponse.fromJson(json['quickCheck']) : null;
    final familySupport = json['familySupport'] != null
        ? GetSectionProgressItemResponse.fromJson(json['familySupport']) : null;
    final spending = json['spending'] != null
        ? GetSectionProgressItemResponse.fromJson(json['spending']) : null;
    final assumption = json['assumption'] != null
        ? GetSectionProgressItemResponse.fromJson(json['assumption']) : null;

    return GetSectionProgressDetailResponse(
      quickCheck: quickCheck,
      familySupport: familySupport,
      spending: spending,
      assumption: assumption,
    );
  }
}

class GetSectionProgressResponse {
  final bool? success;
  final String? planId;
  final GetSectionProgressDetailResponse? progress;

  GetSectionProgressResponse({
    this.success,
    this.planId,
    this.progress,
  });

  factory GetSectionProgressResponse.fromJson(Map<String, dynamic> json) {
    final progress = json['progress'] != null
        ? GetSectionProgressDetailResponse.fromJson(json['progress']) : null;

    return GetSectionProgressResponse(
      success: json['success'] ?? false,
      planId: json['planId'] ?? kString,
      progress: progress,
    );
  }
}