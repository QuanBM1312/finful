import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/section_model.dart';

abstract class StoredDraftState extends Equatable {
  final List<SectionAnswerModel>? onboardingAnswersDraft;

  const StoredDraftState({
    this.onboardingAnswersDraft,
  });

  @override
  List<Object?> get props => [
    onboardingAnswersDraft,
  ];
}

class StoredDraftInitial extends StoredDraftState {
  const StoredDraftInitial({
    required List<SectionAnswerModel>? initOnboardingDraftData,
  }): super(
    onboardingAnswersDraft: initOnboardingDraftData,
  );
}

class StoredDraftUpdateOnboardingDataSuccess extends StoredDraftState {
  const StoredDraftUpdateOnboardingDataSuccess({
    required List<SectionAnswerModel> onboardingAnswersDraft,
  }): super(
    onboardingAnswersDraft: onboardingAnswersDraft,
  );
}

class StoredDraftClearOnboardingDataSuccess extends StoredDraftState {
  const StoredDraftClearOnboardingDataSuccess(): super(
    onboardingAnswersDraft: null,
  );
}