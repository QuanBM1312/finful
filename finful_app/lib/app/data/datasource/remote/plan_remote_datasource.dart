
import 'package:finful_app/app/data/model/request/patch_plan_section_request.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/create_plan_response.dart';
import 'package:finful_app/app/data/model/response/get_plan_response.dart';
import 'package:finful_app/app/data/model/response/patch_plan_section_response.dart';

abstract interface class PlanRemoteDatasource {
  Future<List<GetPlanResponse>> getAllPlans();

  // tao ra planId cho user account
  Future<CreatePlanResponse> postCreatePlan({
    required List<SectionAnswerRequest> request,
  });

  // submit section spending/assumptions calculate
  Future<PatchPlanSectionResponse> patchPlanSection({
    required String planId,
    required PatchPlanSectionRequest request,
  });
}