import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/section/family_support/family_support_bloc.dart';
import 'package:finful_app/app/presentation/blocs/section/family_support/family_support_state.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

mixin FamilySupportBlocMixin {
  FamilySupportState get getFamilySupportState {
    return BlocManager().blocFromKey<FamilySupportBloc>(
        BlocConstants.sectionFamilySupport)!.state;
  }
}