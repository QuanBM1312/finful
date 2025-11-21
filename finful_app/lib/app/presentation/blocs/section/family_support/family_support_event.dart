
import 'package:finful_app/app/domain/model/section_model.dart';

abstract class FamilySupportEvent {
  const FamilySupportEvent();
}

class FamilySupportGetNextStepStarted extends FamilySupportEvent {
  final int nextStep;

  FamilySupportGetNextStepStarted({
    required this.nextStep,
  });
}

class FamilySupportAnswerFilled extends FamilySupportEvent {
  final SectionAnswerModel answer;

  FamilySupportAnswerFilled({
    required this.answer,
  });
}

class FamilySupportGetPreviousStepStarted extends FamilySupportEvent {}

class FamilySupportSubmitAnswerStarted extends FamilySupportEvent {
  final String? planId;

  FamilySupportSubmitAnswerStarted({
    required this.planId,
  });
}

