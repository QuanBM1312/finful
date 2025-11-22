
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/get_section_progress_response.dart';
import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/data/model/response/section_response.dart';

abstract interface class SectionRemoteDatasource {
  Future<SectionResponse> postSectionQA({
    required int nextStep,
    required SectionRequest request,
  });

  Future<SectionOnboardingCalculateResponse> postOnboardingCalculate({
    required List<SectionAnswerRequest> request,
  });

  Future<GetSectionProgressResponse> getCurrentSectionProgress();
}