import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get lightMode => Theme.of(this).brightness == Brightness.light;
  bool get darkMode => Theme.of(this).brightness == Brightness.dark;

  // Media Query
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
}
