# Update Feature Documentation

## Overview

The Update feature allows users to update asset information including asset tag, serial number, photos, condition, status, and other details.

## File Structure

```
lib/presentation/features/dashboard/update/
├── view/
│   ├── screens/
│   │   └── update_verified_asset_screen.dart
│   └── widgets/
│       ├── asset_photo_selector.dart
│       └── custom_dropdown_field.dart
```

## Components

### UpdateVerifiedAssetScreen

Main screen for updating asset information. Features:

- Asset tag input with barcode scanner
- Serial number input with barcode scanner
- Photo selection (max 4 photos)
- Asset condition dropdown
- Asset status dropdown
- Location details (read-only)
- Asset category description (read-only)
- Employee ID and extension number
- FA number
- Old tag input
- Save & Update button

### AssetPhotoSelector Widget

Custom widget for selecting and managing asset photos:

- Allows selection of up to 4 photos
- Photo preview with remove functionality
- Add photo button with camera icon
- Horizontal scrollable photo list

### CustomDropdownField Widget

Reusable dropdown field component:

- Consistent styling with other form fields
- Custom border and colors
- Dropdown arrow icon
- Support for hint text

## Navigation

The screen is accessible from the Activity Selection screen by tapping the "Update" card.

Route: `/update-asset`

## TODO Items

1. Implement image picker functionality for photo selection
2. Add barcode scanning functionality for asset tag and serial number
3. Implement save and update API integration
4. Add form validation
5. Add loading states and error handling
