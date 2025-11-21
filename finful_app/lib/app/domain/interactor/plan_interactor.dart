import 'package:finful_app/app/domain/model/plan_model.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

abstract interface class PlanInteractor {
  Future<PlanModel?> getCurrentPlan();

  Future<PlanModel?> submitCreatePlan({
    required List<SectionAnswerModel> answersFilled,
  });

  Future<void> updateSectionFamilySupportOfPlan({
    required String planId,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<PlanModel?> updateSectionSpendingOfPlan({
    required String planId,
    required List<SectionAnswerModel> answersFilled,
  });

  Future<PlanModel?> updateSectionAssumptionsOfPlan({
    required String planId,
    required List<SectionAnswerModel> answersFilled,
  });
}