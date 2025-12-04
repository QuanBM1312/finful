import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/education_model.dart';

abstract class GetEducationState extends Equatable {
  final List<EducationModel> onboardingEducations;

  const GetEducationState({
    required this.onboardingEducations,
  });

  @override
  List<Object?> get props => [
    onboardingEducations,
  ];
}

class GetEducationInitial extends GetEducationState {
  const GetEducationInitial({
    required List<EducationModel> initOnboardingEducations,
  }): super(
    onboardingEducations: initOnboardingEducations,
  );
}

class GetEducationOnboardingInProgress extends GetEducationState {
  GetEducationOnboardingInProgress(GetEducationState state): super(
    onboardingEducations: state.onboardingEducations,
  );
}

class GetEducationOnboardingSuccess extends GetEducationState {
  const GetEducationOnboardingSuccess(List<EducationModel> data): super(
    onboardingEducations: data,
  );
}

class GetEducationOnboardingFailure extends GetEducationState {
  GetEducationOnboardingFailure(GetEducationState state): super(
    onboardingEducations: state.onboardingEducations,
  );
}