import 'package:fats_amex_nartec/core/extensions/context.dart';
import 'package:fats_amex_nartec/core/utils/navigation_util.dart';
import 'package:fats_amex_nartec/view/screens/dashboard/categories/categories_screen.dart';
import 'package:fats_amex_nartec/view/screens/dashboard/locations/locations_screen.dart';
import 'package:fats_amex_nartec/view/screens/dashboard/verified_assets/verified_assets_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';
import 'dashboard/new_assets/new_assets_screen.dart';

class ActivitySelectionScreen extends StatelessWidget {
  const ActivitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Selections'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: context.lightMode
                  ? AppColors.mintGreen
                  : AppColors.darkMintGreen,
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
              padding: const EdgeInsets.all(16),
              children: [
                _buildActivityCard(
                  context,
                  'Locations',
                  AppIcons.location,
                  onTap: () {
                    NavigationUtil.push(
                      context,
                      const LocationsScreen(),
                    );
                  },
                ),
                _buildActivityCard(
                  context,
                  'Categories',
                  AppIcons.categories,
                  onTap: () {
                    NavigationUtil.push(
                      context,
                      const CategoriesScreen(),
                    );
                  },
                ),
                _buildActivityCard(
                  context,
                  'New Assets',
                  AppIcons.newAssets,
                  onTap: () {
                    NavigationUtil.push(context, const NewAssetsScreen());
                  },
                ),
                _buildActivityCard(
                  context,
                  'Assets Verification',
                  AppIcons.assetsVerification,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  context,
                  'Captured',
                  AppIcons.captured,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  context,
                  'Verified Assets',
                  AppIcons.verifiedAssets,
                  onTap: () {
                    NavigationUtil.push(
                      context,
                      const VerifiedAssetsScreen(),
                    );
                  },
                ),
                _buildActivityCard(
                  context,
                  'Asset Tags',
                  AppIcons.assetsTags,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  context,
                  'Update',
                  AppIcons.update,
                  onTap: () {/* TODO: Handle navigation */},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    String title,
    String iconPath, {
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: [
              Expanded(child: Image.asset(iconPath)),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.lightMode
                        ? AppColors.primaryBlue
                        : AppColors.mintGreen, // Navy blue text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
