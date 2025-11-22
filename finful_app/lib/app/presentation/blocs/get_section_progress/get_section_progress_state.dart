import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/section_progress_model.dart';

abstract class GetSectionProgressState extends Equatable {
  final SectionProgressModel? currentProgress;

  const GetSectionProgressState({
    this.currentProgress,
  });

  @override
  List<Object?> get props => [
    currentProgress,
  ];
}

class GetSectionProgressInitial extends GetSectionProgressState {
  const GetSectionProgressInitial({
    required SectionProgressModel? initCurrentProgress,
  }): super(
    currentProgress: initCurrentProgress,
  );
}

class GetSectionProgressGetCurrentInProgress extends GetSectionProgressState {
  GetSectionProgressGetCurrentInProgress(GetSectionProgressState state): super(
    currentProgress: state.currentProgress,
  );
}

class GetSectionProgressGetCurrentSuccess extends GetSectionProgressState {
  const GetSectionProgressGetCurrentSuccess({
    required SectionProgressModel currentProgress,
  }): super(
    currentProgress: currentProgress,
  );
}

class GetSectionProgressGetCurrentFailure extends GetSectionProgressState {
  GetSectionProgressGetCurrentFailure(GetSectionProgressState state): super(
    currentProgress: state.currentProgress,
  );
}

