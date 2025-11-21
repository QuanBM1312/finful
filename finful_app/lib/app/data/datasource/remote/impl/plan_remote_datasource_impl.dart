import 'package:finful_app/app/data/datasource/remote/plan_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/patch_plan_section_request.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/create_plan_response.dart';
import 'package:finful_app/app/data/model/response/get_plan_response.dart';
import 'package:finful_app/app/data/model/response/patch_plan_section_response.dart';
import 'package:finful_app/core/datasource/base_remote.dart';
import 'package:finful_app/core/datasource/config.dart';

class PlanRemoteDatasourceImpl extends BaseRemote implements PlanRemoteDatasource {
  late final String _host;

  PlanRemoteDatasourceImpl({
    required String host,
    required super.config,
    super.getAuthorization,
  })  : _host = host;

  @override
  Future<List<GetPlanResponse>> getAllPlans() async {
    final url = '$_host/plans';
    final json = await get(url, ApiHeaderType.withToken);
    final jsonData = json;
    final plansJson = jsonData != null && jsonData is List && jsonData.isNotEmpty
        ? List<Map<String, dynamic>>.from(jsonData)
        : null;
    return plansJson?.map(GetPlanResponse.fromJson).toList() ?? <GetPlanResponse>[];
  }

  @override
  Future<CreatePlanResponse> postCreatePlan({
    required List<SectionAnswerRequest> request,
  }) async {
    final url = '$_host/onboarding/start';
    final requestJson = request.toAnswersMap();
    final json = await post(url, ApiHeaderType.withToken, data: requestJson);
    return CreatePlanResponse.fromJson(json);
  }

  @override
  Future<PatchPlanSectionResponse> patchPlanSection({
    required String planId,
    required PatchPlanSectionRequest request,
  }) async {
    final url = '$_host/plans/$planId/section';
    final json =
    await patch(url, ApiHeaderType.withToken, data: request.toJson());
    return PatchPlanSectionResponse.fromJson(json);
  }

}