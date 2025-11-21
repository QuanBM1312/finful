
import 'package:equatable/equatable.dart';
import 'package:finful_app/app/domain/model/plan_model.dart';

abstract class CreatePlanState extends Equatable {
  final PlanModel? createdPlan;

  const CreatePlanState({
    this.createdPlan,
  });

  @override
  List<Object?> get props => [
    createdPlan,
  ];
}

class CreatePlanInitial extends CreatePlanState {
  const CreatePlanInitial(): super();
}

class CreatePlanInProgress extends CreatePlanState {
  const CreatePlanInProgress(): super();
}

class CreatePlanSuccess extends CreatePlanState {
  const CreatePlanSuccess({
    required PlanModel createdPlan,
  }): super(
    createdPlan: createdPlan,
  );
}

class CreatePlanFailure extends CreatePlanState {
  const CreatePlanFailure(): super();
}