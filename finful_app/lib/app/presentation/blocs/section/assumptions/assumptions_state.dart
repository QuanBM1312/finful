import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/plan_model.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

enum AssumptionsCalculateFailureType { missingPlanId, api }

abstract class AssumptionsState extends Equatable {
  final List<SectionModel> sectionAssumptions;
  final PlanModel? calculateResult;

  const AssumptionsState({
    required this.sectionAssumptions,
    this.calculateResult,
  });

  @override
  List<Object?> get props => [
    sectionAssumptions,
    calculateResult,
  ];
}

class AssumptionsInitial extends AssumptionsState {
  const AssumptionsInitial({
    required List<SectionModel> initSection,
    required PlanModel? initCalculateResult,
  }) : super(
    sectionAssumptions: initSection,
    calculateResult: initCalculateResult,
  );
}

class AssumptionsGetNextStepInProgress extends AssumptionsState {
  AssumptionsGetNextStepInProgress(AssumptionsState state) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

class AssumptionsGetNextStepSuccess extends AssumptionsState {
  const AssumptionsGetNextStepSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionAssumptions: latestSections,
  );
}

class AssumptionsGetNextStepFailure extends AssumptionsState {
  AssumptionsGetNextStepFailure(AssumptionsState state) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

class AssumptionsFillAnswerInProgress extends AssumptionsState {
  AssumptionsFillAnswerInProgress(AssumptionsState state) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

class AssumptionsFillAnswerSuccess extends AssumptionsState {
  const AssumptionsFillAnswerSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionAssumptions: latestSections,
  );
}

class AssumptionsGetPreviousStepInProgress extends AssumptionsState {
  AssumptionsGetPreviousStepInProgress(AssumptionsState state) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

class AssumptionsGetPreviousStepSuccess extends AssumptionsState {
  const AssumptionsGetPreviousStepSuccess({
    required List<SectionModel> latestSections,
  }) : super(
    sectionAssumptions: latestSections,
  );
}

class AssumptionsCalculateInProgress extends AssumptionsState {
  AssumptionsCalculateInProgress(AssumptionsState state) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

class AssumptionsCalculateSuccess extends AssumptionsState {
  AssumptionsCalculateSuccess({
    required AssumptionsState state,
    required PlanModel calculateResult,
  }) : super(
      sectionAssumptions: state.sectionAssumptions,
      calculateResult: calculateResult
  );
}

class AssumptionsCalculateFailure extends AssumptionsState {
  AssumptionsCalculateFailure({
    required AssumptionsState state,
    required AssumptionsCalculateFailureType failedType,
  }) : super(
    sectionAssumptions: state.sectionAssumptions,
  );
}

