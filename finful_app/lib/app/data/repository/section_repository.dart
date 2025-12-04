import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/get_education_response.dart';
import 'package:finful_app/app/data/model/response/get_section_progress_response.dart';
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

  Future<GetSectionProgressResponse> getCurrentSectionProgress();

  Future<List<GetEducationResponse>> getEducation({
    required String type,
    required String location,
  });
}