import 'package:finful_app/app/domain/model/section_model.dart';

abstract class AssumptionsEvent {
  const AssumptionsEvent();
}

class AssumptionsGetNextStepStarted extends AssumptionsEvent {
  final int nextStep;

  AssumptionsGetNextStepStarted({
    required this.nextStep,
  });
}

class AssumptionsAnswerFilled extends AssumptionsEvent {
  final SectionAnswerModel answer;

  AssumptionsAnswerFilled({
    required this.answer,
  });
}

class AssumptionsGetPreviousStepStarted extends AssumptionsEvent {}

class AssumptionsCalculateStarted extends AssumptionsEvent {
  final String? planId;

  AssumptionsCalculateStarted({
    required this.planId,
  });
}
