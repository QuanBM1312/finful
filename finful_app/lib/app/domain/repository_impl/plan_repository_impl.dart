import 'package:finful_app/app/data/datasource/remote/plan_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/patch_plan_section_request.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/create_plan_response.dart';
import 'package:finful_app/app/data/model/response/get_plan_response.dart';
import 'package:finful_app/app/data/model/response/patch_plan_section_response.dart';
import 'package:finful_app/app/data/repository/plan_repository.dart';

class PlanRepositoryImpl implements PlanRepository {
  late final PlanRemoteDatasource _planRemoteDatasource;

  PlanRepositoryImpl({
    required PlanRemoteDatasource planRemoteDatasource,
  }) : _planRemoteDatasource = planRemoteDatasource;

  @override
  Future<List<GetPlanResponse>> getAllPlans() async {
    final response = await _planRemoteDatasource.getAllPlans();
    return response;
  }

  @override
  Future<CreatePlanResponse> createPlan({
    required List<SectionAnswerRequest> request,
  }) async {
    final response = await _planRemoteDatasource.postCreatePlan(
        request: request,
    );
    return response;
  }

  @override
  Future<PatchPlanSectionResponse> updateSectionOfPlan({
    required String planId,
    required PatchPlanSectionRequest request,
  }) async {
    final response = await _planRemoteDatasource.patchPlanSection(
      planId: planId,
      request: request,
    );
    return response;
  }

}