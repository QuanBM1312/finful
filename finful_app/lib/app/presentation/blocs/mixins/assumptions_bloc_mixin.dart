
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/section/assumptions/assumptions.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

mixin AssumptionsBlocMixin {
  AssumptionsState get getAssumptionsState {
    return BlocManager().blocFromKey<AssumptionsBloc>(
        BlocConstants.sectionAssumptions)!.state;
  }
}