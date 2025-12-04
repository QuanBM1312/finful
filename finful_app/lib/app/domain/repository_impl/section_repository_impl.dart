import 'package:finful_app/app/data/datasource/remote/section_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
import 'package:finful_app/app/data/model/response/get_education_response.dart';
import 'package:finful_app/app/data/model/response/get_section_progress_response.dart';
import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/data/model/response/section_response.dart';
import 'package:finful_app/app/data/repository/section_repository.dart';

class SectionRepositoryImpl implements SectionRepository {
  late final SectionRemoteDatasource _sectionRemoteDatasource;

  SectionRepositoryImpl({
    required SectionRemoteDatasource sectionRemoteDatasource,
  })  : _sectionRemoteDatasource = sectionRemoteDatasource;

  @override
  Future<SectionResponse> getSectionQA({
    required int nextStep,
    required SectionRequest request,
  }) async {
    final response = await _sectionRemoteDatasource.postSectionQA(
        nextStep: nextStep,
        request: request
    );
    return response;
  }

  @override
  Future<SectionOnboardingCalculateResponse> submitOnboardingCalculate({
    required List<SectionAnswerRequest> request
  }) async {
    final response = await _sectionRemoteDatasource.postOnboardingCalculate(
      request: request,
    );
    return response;
  }

  @override
  Future<GetSectionProgressResponse> getCurrentSectionProgress() async {
    final response = await _sectionRemoteDatasource.getCurrentSectionProgress();
    return response;
  }

  @override
  Future<List<GetEducationResponse>> getEducation({
    required String type,
    required String location,
  }) async {
    final response = await _sectionRemoteDatasource.getEducation(
      type: type,
      location: location,
    );
    return response;
  }

}