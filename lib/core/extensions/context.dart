import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get lightMode => Theme.of(this).brightness == Brightness.light;
}
