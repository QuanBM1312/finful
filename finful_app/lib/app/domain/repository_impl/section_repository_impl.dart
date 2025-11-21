import 'package:finful_app/app/data/datasource/remote/section_remote_datasource.dart';
import 'package:finful_app/app/data/model/request/query_section_request.dart';
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

}