import 'package:flutter/material.dart';

abstract class INavigator {
  /// pushNamed functions
  Future<T?> pushNamed<T extends Object?>(
      String routeName, {
        BaseRouter? router,
      });

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        BaseRouter? router,
      });

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String routeName,
      RoutePredicate predicate, {
        BaseRouter? router,
      });

  /// pop functions
  void pop();

  void popUntil(RoutePredicate predicate);
}

abstract class BaseRouter implements INavigator {
  GlobalKey<NavigatorState> navigatorKey;

  BaseRouter({required this.navigatorKey});

  Future<T?> start<T extends Object?>();

  @override
  Future<T?> pushNamed<T extends Object?>(
      String routeName, {
        BaseRouter? router,
      }) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: router,
    );
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        BaseRouter? router,
      }) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      result: result,
      arguments: router,
    );
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String routeName,
      RoutePredicate predicate, {
        BaseRouter? router,
      }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: router,
    );
  }

  @override
  void pop() {
    return navigatorKey.currentState!.pop();
  }

  @override
  void popUntil(RoutePredicate predicate) {
    return navigatorKey.currentState!.popUntil(predicate);
  }
}
