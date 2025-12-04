import 'package:finful_app/app/data/datasource/remote/section_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/get_education_response.dart';
import 'package:finful_app/app/data/model/response/get_section_progress_response.dart';
import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/data/model/response/section_response.dart';
import 'package:finful_app/core/datasource/base_remote.dart';
import 'package:finful_app/core/datasource/config.dart';

class SectionRemoteDatasourceImpl extends BaseRemote implements SectionRemoteDatasource {
  late final String _host;

  SectionRemoteDatasourceImpl({
    required String host,
    required super.config,
    super.getAuthorization,
  }) : _host = host;

  @override
  Future<SectionResponse> postSectionQA({
    required int nextStep,
    required SectionRequest request
  }) async {
    final url = '$_host/section/next-step?index=$nextStep';
    final json =
    await post(url, ApiHeaderType.withoutToken, data: request.toJson());
    return SectionResponse.fromJson(json);
  }

  @override
  Future<SectionOnboardingCalculateResponse> postOnboardingCalculate({
    required List<SectionAnswerRequest> request,
  }) async {
    final url = '$_host/onboarding/calculate';
    final requestJson = request.toAnswersMap();
    final json =
    await post(url, ApiHeaderType.withoutToken, data: requestJson);
    return SectionOnboardingCalculateResponse.fromJson(json);
  }

  @override
  Future<GetSectionProgressResponse> getCurrentSectionProgress() async {
    final url = '$_host/section/progress';
    final json = await get(url, ApiHeaderType.withToken);
    return GetSectionProgressResponse.fromJson(json);
  }

  @override
  Future<List<GetEducationResponse>> getEducation({
    required String type,
    required String location,
  }) async {
    final url = '$_host/education?type=$type&location=$location';
    final json = await get(url, ApiHeaderType.withoutToken);
    final jsonData = json;
    final plansJson = jsonData != null && jsonData is List && jsonData.isNotEmpty
        ? List<Map<String, dynamic>>.from(jsonData)
        : null;
    return plansJson?.map(GetEducationResponse.fromJson).toList() ?? <GetEducationResponse>[];
  }
}