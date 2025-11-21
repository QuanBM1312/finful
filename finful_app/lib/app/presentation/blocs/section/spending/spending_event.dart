import 'package:finful_app/app/domain/model/section_model.dart';

abstract class SpendingEvent {
  const SpendingEvent();
}

class SpendingGetNextStepStarted extends SpendingEvent {
  final int nextStep;

  SpendingGetNextStepStarted({
    required this.nextStep,
  });
}

class SpendingAnswerFilled extends SpendingEvent {
  final SectionAnswerModel answer;

  SpendingAnswerFilled({
    required this.answer,
  });
}

class SpendingGetPreviousStepStarted extends SpendingEvent {}

class SpendingCalculateStarted extends SpendingEvent {
  final String? planId;
  final List<SectionAnswerModel> familySupportAnswersFilled;

  SpendingCalculateStarted({
    required this.planId,
    required this.familySupportAnswersFilled,
  });
}
