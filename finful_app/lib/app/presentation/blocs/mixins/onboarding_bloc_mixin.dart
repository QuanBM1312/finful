
import 'package:finful_app/app/constants/key/BlocConstants.dart';
import 'package:finful_app/app/presentation/blocs/section/onboarding/onboarding.dart';
import 'package:finful_app/core/bloc/base/bloc_manager.dart';

mixin OnboardingBlocMixin {
  OnboardingState get getOnboardingState {
    return BlocManager().blocFromKey<OnboardingBloc>(
        BlocConstants.sectionOnboarding)!.state;
  }
}