import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRedirect {
  static final instance = AppRedirect._();

  AppRedirect._();

  factory AppRedirect() {
    return instance;
  }

  /// Redirect logic to determine the initial route based on authentication state
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    // Example logic: Check if user is authenticated
    return null;
  }
}
