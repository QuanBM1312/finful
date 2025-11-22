import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/domain/model/section_model.dart';
import 'package:finful_app/app/domain/model/section_progress_model.dart';

abstract interface class SectionInteractor {
  Future<SectionModel> getSectionOnboardingQA({
    required int nextStep,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<SectionOnboardingCalculateResponse> submitSectionOnboardingCalculate({
    required List<SectionAnswerModel> answersFilled,
  });

  Future<SectionModel> getSectionFamilySupportQA({
    required int nextStep,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<SectionModel> getSectionSpendingQA({
    required int nextStep,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<SectionModel> getSectionAssumptionsQA({
    required int nextStep,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<SectionProgressModel> getCurrentSectionProgress();
}