
import 'package:equatable/equatable.dart';
import 'package:finful_app/app/data/model/response/section_onboarding_calculate_response.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

abstract class OnboardingState extends Equatable {
  final List<SectionModel> sectionOnboardings;
  final SectionOnboardingCalculateResponse? calculateResult;

  const OnboardingState({
    required this.sectionOnboardings,
    this.calculateResult,
  });

  @override
  List<Object?> get props => [
    sectionOnboardings,
    calculateResult,
  ];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    required List<SectionModel> initSection,
    required SectionOnboardingCalculateResponse? initCalculateResult,
}) : super(
      sectionOnboardings: initSection,
      calculateResult: initCalculateResult,
  );
}

class OnboardingGetNextStepInProgress extends OnboardingState {
  OnboardingGetNextStepInProgress(OnboardingState state) : super(
      sectionOnboardings: state.sectionOnboardings,
  );
}

class OnboardingGetNextStepSuccess extends OnboardingState {
  const OnboardingGetNextStepSuccess({
    required List<SectionModel> latestSections,
  }) : super(
      sectionOnboardings: latestSections,
  );
}

class OnboardingGetNextStepFailure extends OnboardingState {
  OnboardingGetNextStepFailure(OnboardingState state) : super(
    sectionOnboardings: state.sectionOnboardings,
  );
}

class OnboardingFillAnswerInProgress extends OnboardingState {
  OnboardingFillAnswerInProgress(OnboardingState state) : super(
    sectionOnboardings: state.sectionOnboardings,
  );
}

class OnboardingFillAnswerSuccess extends OnboardingState {
  const OnboardingFillAnswerSuccess({
    required List<SectionModel> latestSections,
}) : super(
    sectionOnboardings: latestSections,
  );
}

class OnboardingGetPreviousStepInProgress extends OnboardingState {
  OnboardingGetPreviousStepInProgress(OnboardingState state) : super(
    sectionOnboardings: state.sectionOnboardings,
  );
}

class OnboardingGetPreviousStepSuccess extends OnboardingState {
  const OnboardingGetPreviousStepSuccess({
    required List<SectionModel> latestSections,
}) : super(
    sectionOnboardings: latestSections,
  );
}

class OnboardingCalculateInProgress extends OnboardingState {
  OnboardingCalculateInProgress(OnboardingState state) : super(
    sectionOnboardings: state.sectionOnboardings,
  );
}

class OnboardingCalculateSuccess extends OnboardingState {
  OnboardingCalculateSuccess({
    required OnboardingState state,
    required SectionOnboardingCalculateResponse calculateResult,
  }) : super(
    sectionOnboardings: state.sectionOnboardings,
    calculateResult: calculateResult
  );
}

class OnboardingCalculateFailure extends OnboardingState {
  OnboardingCalculateFailure(OnboardingState state) : super(
    sectionOnboardings: state.sectionOnboardings,
  );
}





