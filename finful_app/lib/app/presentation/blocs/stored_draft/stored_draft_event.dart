import 'package:finful_app/app/domain/model/section_model.dart';

abstract class StoredDraftEvent {
  const StoredDraftEvent();
}

class StoredDraftUpdateOnboardingDataStarted extends StoredDraftEvent {
  final List<SectionAnswerModel> onboardingAnswers;

  StoredDraftUpdateOnboardingDataStarted({
    required this.onboardingAnswers,
  });
}

class StoredDraftClearOnboardingDataStarted extends StoredDraftEvent {
  StoredDraftClearOnboardingDataStarted();
}