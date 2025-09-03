import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AssetPhotoSelector extends StatefulWidget {
  final Function(List<String>) onPhotosChanged;
  final int maxPhotos;

  const AssetPhotoSelector({
    super.key,
    required this.onPhotosChanged,
    this.maxPhotos = 4,
  });

  @override
  State<AssetPhotoSelector> createState() => _AssetPhotoSelectorState();
}

class _AssetPhotoSelectorState extends State<AssetPhotoSelector> {
  final List<String> _selectedPhotos = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textFieldLightYellow.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Add photo button
          _buildAddPhotoButton(),
          const SizedBox(width: 12),
          // Selected photos
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ..._selectedPhotos.asMap().entries.map((entry) {
                    int index = entry.key;
                    String photo = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildPhotoPreview(photo, index),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return GestureDetector(
      onTap: _selectedPhotos.length < widget.maxPhotos ? _addPhoto : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryBlue.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 24,
              color: _selectedPhotos.length < widget.maxPhotos
                  ? AppColors.primaryBlue
                  : AppColors.primaryBlue.withOpacity(0.5),
            ),
            const SizedBox(height: 4),
            Icon(
              Icons.add,
              size: 16,
              color: _selectedPhotos.length < widget.maxPhotos
                  ? AppColors.primaryBlue
                  : AppColors.primaryBlue.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPreview(String photo, int index) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primaryBlue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              // Placeholder for actual image
              color: AppColors.primaryBlue.withOpacity(0.1),
              child: const Icon(
                Icons.image,
                size: 32,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removePhoto(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 14,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addPhoto() {
    // TODO: Implement image picker functionality
    if (_selectedPhotos.length < widget.maxPhotos) {
      setState(() {
        _selectedPhotos.add('photo_${_selectedPhotos.length + 1}');
      });
      widget.onPhotosChanged(_selectedPhotos);
    }

    // For now, we'll just add placeholder photos
    // In a real implementation, you would use image_picker package
    print('Adding photo... Current count: ${_selectedPhotos.length}');
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
    widget.onPhotosChanged(_selectedPhotos);
  }
}
