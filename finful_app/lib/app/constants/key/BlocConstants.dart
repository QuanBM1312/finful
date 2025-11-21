import 'package:flutter/material.dart';

class BlocConstants {
  BlocConstants._();
  // common
  static const Key noneDispose = Key('none_dispose_bloc');
  static const Key forceToDispose = Key('force_to_dispose_bloc');
  static const Key loader = Key('loader_bloc');
  static const Key connectivity = Key('connectivity_bloc');
  static const Key showMessage = Key('show_message_bloc');
  static const Key session = Key('session_bloc');

  // authentication
  static const Key signIn = Key('sign_in_bloc');
  static const Key signUp = Key('sign_up_bloc');

  // section
  static const Key sectionOnboarding = Key('section_onboarding_bloc');
  static const Key sectionFamilySupport = Key('section_family_support_bloc');
  static const Key sectionSpending = Key('section_spending_bloc');
  static const Key sectionAssumptions = Key('section_assumptions_bloc');

  // plan
  static const Key getPlan = Key('get_plan_bloc');
  static const Key createPlan = Key('create_plan_bloc');
}

class BlocBroadcastEventConstants {
  static const String justLoggedIn = 'broadcast_just_logged_in';

  // params
  static String userData = 'user_data';
}

