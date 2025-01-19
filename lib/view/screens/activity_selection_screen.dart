import 'package:flutter/material.dart';

import '../../../core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';

class ActivitySelectionScreen extends StatelessWidget {
  const ActivitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      appBar: AppBar(
        title: const Text('Activity Selections'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9), // Light mint green background
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
                  'Locations',
                  AppIcons.location,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'Categories',
                  AppIcons.categories,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'New Assets',
                  AppIcons.newAssets,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'Assets Verification',
                  AppIcons.assetsVerification,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'Captured',
                  AppIcons.captured,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'Verified Assets',
                  AppIcons.verifiedAssets,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
                  'Asset Tags',
                  AppIcons.assetsTags,
                  onTap: () {/* TODO: Handle navigation */},
                ),
                _buildActivityCard(
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
            children: [
              Image.asset(
                iconPath,
                height: 48,
                width: 48,
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlue, // Navy blue text
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
