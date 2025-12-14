import 'package:flutter/material.dart';

/// Mobile Navigator-based routing system
/// This provides a clean, type-safe way to navigate in mobile applications
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get current context
  static BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate to a named route
  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate to a route and remove all previous routes
  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  /// Navigate to a route and remove all previous routes (go to new route)
  static Future<T?>? pushNamedAndClearStack<T extends Object?>(
    String newRouteName, {
    Object? arguments,
  }) {
    return pushNamedAndRemoveUntil<T>(
      newRouteName,
      (route) => false, // Remove all routes
      arguments: arguments,
    );
  }

  /// Replace current route with a new route
  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  /// Pop current route
  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop<T>(result);
  }

  /// Check if can pop
  static bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }

  /// Pop until a specific route
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil((route) {
      return route.settings.name == routeName || route.isFirst;
    });
  }
}
