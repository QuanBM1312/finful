import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/plan_model.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

enum SpendingCalculateFailureType { missingPlanId, api }

abstract class SpendingState extends Equatable {
  final List<SectionModel> sectionSpendings;
  final PlanModel? calculateResult;

  const SpendingState({
    required this.sectionSpendings,
    this.calculateResult,
  });

  @override
  List<Object?> get props => [
    sectionSpendings,
    calculateResult,
  ];
}

class SpendingInitial extends SpendingState {
  const SpendingInitial({
    required List<SectionModel> initSection,
    required PlanModel? initCalculateResult,
  }) : super(
    sectionSpendings: initSection,
    calculateResult: initCalculateResult,
  );
}

class SpendingGetNextStepInProgress extends SpendingState {
  SpendingGetNextStepInProgress(SpendingState state) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

class SpendingGetNextStepSuccess extends SpendingState {
  const SpendingGetNextStepSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionSpendings: latestSections,
  );
}

class SpendingGetNextStepFailure extends SpendingState {
  SpendingGetNextStepFailure(SpendingState state) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

class SpendingFillAnswerInProgress extends SpendingState {
  SpendingFillAnswerInProgress(SpendingState state) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

class SpendingFillAnswerSuccess extends SpendingState {
  const SpendingFillAnswerSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionSpendings: latestSections,
  );
}

class SpendingGetPreviousStepInProgress extends SpendingState {
  SpendingGetPreviousStepInProgress(SpendingState state) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

class SpendingGetPreviousStepSuccess extends SpendingState {
  const SpendingGetPreviousStepSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionSpendings: latestSections,
  );
}

class SpendingCalculateInProgress extends SpendingState {
  SpendingCalculateInProgress(SpendingState state) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

class SpendingCalculateSuccess extends SpendingState {
  SpendingCalculateSuccess({
    required SpendingState state,
    required PlanModel calculateResult,
  }) : super(
      sectionSpendings: state.sectionSpendings,
      calculateResult: calculateResult
  );
}

class SpendingCalculateFailure extends SpendingState {
  SpendingCalculateFailure({
    required SpendingState state,
    required SpendingCalculateFailureType failedType,
}) : super(
    sectionSpendings: state.sectionSpendings,
  );
}

