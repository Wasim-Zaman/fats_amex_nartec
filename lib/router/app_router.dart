import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/screens/activity_selection_screen.dart';
import '../view/screens/auth/login_screen.dart';
import '../view/screens/dashboard/categories/categories_screen.dart';
import '../view/screens/dashboard/locations/assets_location_screen.dart';
import '../view/screens/dashboard/locations/locations_screen.dart';
import '../view/screens/dashboard/new_assets/new_assets_screen.dart';
import '../view/screens/dashboard/verified_assets/verified_assets_screen.dart';
import 'app_redirect.dart';
import 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login,
    redirect: AppRedirect.instance.redirect,
    routes: [
      // Login Screen (root)
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginScreen(),
      ),

      // Activity Selection Screen
      GoRoute(
        path: AppRoutes.activitySelection,
        name: AppRoutes.activitySelectionName,
        builder: (context, state) => const ActivitySelectionScreen(),
      ),

      // Categories Screen
      GoRoute(
        path: AppRoutes.categories,
        name: AppRoutes.categoriesName,
        builder: (context, state) => const CategoriesScreen(),
      ),

      // Locations Screen
      GoRoute(
        path: AppRoutes.locations,
        name: AppRoutes.locationsName,
        builder: (context, state) => const LocationsScreen(),
      ),

      // Assets Location Screen
      GoRoute(
        path: AppRoutes.assetsLocation,
        name: AppRoutes.assetsLocationName,
        builder: (context, state) => const AssetsLocationsScreen(),
      ),

      // New Assets Screen
      GoRoute(
        path: AppRoutes.newAssets,
        name: AppRoutes.newAssetsName,
        builder: (context, state) => const NewAssetsScreen(),
      ),

      // Verified Assets Screen
      GoRoute(
        path: AppRoutes.verifiedAssets,
        name: AppRoutes.verifiedAssetsName,
        builder: (context, state) => const VerifiedAssetsScreen(),
      ),
    ],

    // Error page builder
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    ),
  );
}
