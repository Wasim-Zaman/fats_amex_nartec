import 'package:flutter/material.dart';

import 'core/constants/constants.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'view/screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fats Amex',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
