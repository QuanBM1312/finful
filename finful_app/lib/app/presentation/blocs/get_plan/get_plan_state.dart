import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/plan_model.dart';

abstract class GetPlanState extends Equatable {
  final PlanModel? currentPlan;

  const GetPlanState({
    this.currentPlan,
  });

  @override
  List<Object?> get props => [
    currentPlan,
  ];
}

class GetPlanInitial extends GetPlanState {
  const GetPlanInitial({
    required PlanModel? initPlan,
}): super(
    currentPlan: initPlan,
  );
}

class GetPlanGetCurrentPlanInProgress extends GetPlanState {
  GetPlanGetCurrentPlanInProgress(GetPlanState state): super(
    currentPlan: state.currentPlan,
  );
}

class GetPlanGetCurrentPlanSuccess extends GetPlanState {
  const GetPlanGetCurrentPlanSuccess({
    required PlanModel currentPlan,
}): super(
    currentPlan: currentPlan,
  );
}

class GetPlanGetCurrentPlanFailure extends GetPlanState {
  GetPlanGetCurrentPlanFailure(GetPlanState state): super(
    currentPlan: state.currentPlan,
  );
}