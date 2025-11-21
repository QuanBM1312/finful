
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/data/model/response/section_response.dart';

abstract interface class SectionRepository {
  Future<SectionResponse> getSectionQA({
    required int nextStep,
    required SectionRequest request,
  });

  Future<SectionOnboardingCalculateResponse> submitOnboardingCalculate({
    required List<SectionAnswerRequest> request,
  });
}