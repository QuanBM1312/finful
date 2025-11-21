
import 'package:finful_app/app/constants/route.dart';
import 'package:finful_app/app/presentation/journey/dashboard/dashboard_router.dart';
import 'package:finful_app/app/routes/app_routes.dart';
import 'package:finful_app/core/presentation/base_router.dart';
import 'package:flutter/material.dart';

abstract interface class ISignInRouter {
  void gotoSignUp();

  void gotoForgotPassword();

  void gotoDashboard();
}

class SignInRouter extends BaseRouter implements ISignInRouter {
  SignInRouter() : super(navigatorKey: AppRoutes.shared.navigatorKey);

  @override
  void gotoDashboard() {
    final router = DashboardRouter();
    router.startAndRemoveUntil(null);
  }

  @override
  void gotoForgotPassword() {
    // TODO: implement gotoForgotPassword
  }

  @override
  void gotoSignUp() {
    // TODO: implement gotoSignUp
  }

  @override
  Future<T?> start<T extends Object?>() {
    return pushNamed(RouteConstant.signIn, router: this);
  }

  void startAndRemoveUntil(bool Function(Route p1)? predicate) {
    pushNamedAndRemoveUntil(
      RouteConstant.signIn,
      predicate ?? (route) => false,
      router: this,
    );
  }
}