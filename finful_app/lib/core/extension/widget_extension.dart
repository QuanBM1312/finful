import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

enum TransitionType { fade, normal, none }

extension OCPageBuilder on Widget {
  PageRouteBuilder buildPage({
    PageTransitionType transitionType = PageTransitionType.theme,
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return PageTransition(
      child: this,
      type: transitionType,
      duration: duration,
      reverseDuration: duration,
      settings: settings,
    );
  }
}
