
import 'package:finful_app/app/domain/model/section_model.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

class OnboardingGetNextStepStarted extends OnboardingEvent {
  final int nextStep;

  OnboardingGetNextStepStarted({
    required this.nextStep,
 });
}

class OnboardingAnswerFilled extends OnboardingEvent {
  final SectionAnswerModel answer;

  OnboardingAnswerFilled({
    required this.answer,
  });
}

class OnboardingGetPreviousStepStarted extends OnboardingEvent {}

class OnboardingCalculateStarted extends OnboardingEvent {}