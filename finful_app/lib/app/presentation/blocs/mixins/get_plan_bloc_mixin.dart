import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/get_plan/get_plan.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

mixin GetPlanBlocMixin {
  GetPlanState get getPlanState {
    return BlocManager().blocFromKey<GetPlanBloc>(
        BlocConstants.getPlan)!.state;
  }
}