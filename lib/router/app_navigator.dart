import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation helper class to provide convenient methods for navigation
/// This replaces the old AppNavigator functionality with go_router
class AppNavigator {
  AppNavigator._();

  /// Navigate to a route using path
  static void go(BuildContext context, String path) {
    context.go(path);
  }

  /// Push a new route onto the stack
  static void push(BuildContext context, String path) {
    context.push(path);
  }

  /// Replace the current route
  static void pushReplacement(BuildContext context, String path) {
    context.pushReplacement(path);
  }

  /// Navigate to a route and clear the stack
  static void pushAndRemoveUntil(BuildContext context, String path) {
    context.go(path);
  }

  /// Pop the current route
  static void pop<T>(BuildContext context, [T? result]) {
    context.pop(result);
  }

  /// Go back to previous route
  static void back(BuildContext context) {
    context.pop();
  }

  /// Navigate using route name with optional parameters
  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Go to a named route
  static void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Replace current route with named route
  static void pushReplacementNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    context.pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Check if we can pop the current route
  static bool canPop(BuildContext context) {
    return context.canPop();
  }
}
