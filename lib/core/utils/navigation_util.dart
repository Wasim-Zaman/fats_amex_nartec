import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationUtil {
  // Prevent instantiation
  NavigationUtil._();

  // Default transition duration
  static const Duration _defaultDuration = Duration(milliseconds: 500);

  /// Navigate to a new screen with fade transition
  static Future<T?> push<T>(
    BuildContext context,
    Widget screen, {
    Duration duration = _defaultDuration,
  }) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        duration: duration,
      ),
    );
  }

  /// Navigate to a new screen and remove all previous screens
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget screen, {
    Duration duration = _defaultDuration,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        duration: duration,
      ),
      (route) => false,
    );
  }

  /// Navigate to a new screen and replace the current screen
  static Future<T?> pushReplacement<T>(
    BuildContext context,
    Widget screen, {
    Duration duration = _defaultDuration,
  }) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
        duration: duration,
      ),
    );
  }

  /// Pop the current screen
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
