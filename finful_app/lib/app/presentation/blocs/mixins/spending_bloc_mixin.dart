
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/section/spending/spending.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

mixin SpendingBlocMixin {
  SpendingState get getSpendingState {
    return BlocManager().blocFromKey<SpendingBloc>(
        BlocConstants.sectionSpending)!.state;
  }
}