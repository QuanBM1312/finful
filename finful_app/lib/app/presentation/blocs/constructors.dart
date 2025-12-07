import 'package:finful_app/app/domain/interactor/auth_interactor.dart';
import 'package:finful_app/app/domain/interactor/plan_interactor.dart';
import 'package:finful_app/app/domain/interactor/section_interactor.dart';
import 'package:finful_app/app/domain/interactor/session_interactor.dart';
import 'package:finful_app/app/domain/interactor/user_interactor.dart';
import 'package:finful_app/app/injection/injection.dart';
import 'package:finful_app/app/presentation/blocs/account_tab/account_tab_bloc.dart';
import 'package:flutter/foundation.dart';

import 'common/connectivity/connectivity_bloc.dart';
import 'common/loader/loader_bloc.dart';
import 'common/session/session_bloc.dart';
import 'common/show_message/show_message_bloc.dart';
import 'create_plan/create_plan_bloc.dart';
import 'get_education/get_education.dart';
import 'get_plan/get_plan_bloc.dart';
import 'get_section_progress/get_section_progress_bloc.dart';
import 'section/assumptions/assumptions_bloc.dart';
import 'section/family_support/family_support_bloc.dart';
import 'section/onboarding/onboarding_bloc.dart';
import 'section/spending/spending_bloc.dart';
import 'signin/signin_bloc.dart';
import 'signup/signup_bloc.dart';
import 'stored_draft/stored_draft_bloc.dart';

final Map<Type, Object Function(Key key)> blocConstructors = {
  LoaderBloc: LoaderBloc.new,
  ConnectivityBloc: ConnectivityBloc.new,
  ShowMessageBloc: ShowMessageBloc.new,
  SessionBloc: (Key key) => SessionBloc(
    key,
    sessionInteractor: Injection().getIt<SessionInteractor>(),
    userInteractor: Injection().getIt<UserInteractor>(),
    authInteractor: Injection().getIt<AuthInteractor>(),
  ),
  SignInBloc: (Key key) => SignInBloc(
      key,
      authInteractor: Injection().getIt<AuthInteractor>(),
    userInteractor: Injection().getIt<UserInteractor>(),
  ),
  SignUpBloc: (Key key) => SignUpBloc(
    key,
    authInteractor: Injection().getIt<AuthInteractor>(),
  ),
  OnboardingBloc: (Key key) => OnboardingBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
  ),
  FamilySupportBloc: (Key key) => FamilySupportBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
    planInteractor: Injection().getIt<PlanInteractor>(),
  ),
  SpendingBloc: (Key key) => SpendingBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
    planInteractor: Injection().getIt<PlanInteractor>(),
  ),
  AssumptionsBloc: (Key key) => AssumptionsBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
    planInteractor: Injection().getIt<PlanInteractor>(),
  ),
  GetPlanBloc: (Key key) => GetPlanBloc(
    key,
    planInteractor: Injection().getIt<PlanInteractor>(),
  ),
  CreatePlanBloc: (Key key) => CreatePlanBloc(
    key,
    planInteractor: Injection().getIt<PlanInteractor>(),
  ),
  GetSectionProgressBloc: (Key key) => GetSectionProgressBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
  ),
  StoredDraftBloc: StoredDraftBloc.new,
  GetEducationBloc: (Key key) => GetEducationBloc(
    key,
    sectionInteractor: Injection().getIt<SectionInteractor>(),
  ),
  AccountTabBloc: (Key key) => AccountTabBloc(
    key,
    userInteractor: Injection().getIt<UserInteractor>(),
  ),
};