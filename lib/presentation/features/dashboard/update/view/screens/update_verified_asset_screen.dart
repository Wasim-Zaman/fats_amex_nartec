import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:fats_amex_nartec/core/extensions/context.dart';
import 'package:fats_amex_nartec/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:fats_amex_nartec/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../widgets/asset_photo_selector.dart';
import '../widgets/custom_dropdown_field.dart';

class UpdateVerifiedAssetScreen extends StatefulWidget {
  const UpdateVerifiedAssetScreen({super.key});

  @override
  State<UpdateVerifiedAssetScreen> createState() =>
      _UpdateVerifiedAssetScreenState();
}

class _UpdateVerifiedAssetScreenState extends State<UpdateVerifiedAssetScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _assetTagController = TextEditingController(text: '100078100015');
  final _serialNumberController =
      TextEditingController(text: '102531100000YT5');
  final _locationController = TextEditingController(text: 'AMEX-HO-2F-01-00');
  final _categoryController = TextEditingController(text: 'Office Table');
  final _employeeIdController = TextEditingController(text: '4085');
  final _extNumberController = TextEditingController(text: '1415');
  final _faNumberController = TextEditingController(text: 'FA001245');
  final _oldTagController = TextEditingController(text: '123658977711');

  // Dropdown values
  String _selectedCondition = 'Excellent';
  String _selectedStatus = 'New';

  // Photo selection
  List<String> _selectedPhotos = [];

  final List<String> _conditionOptions = [
    'Excellent',
    'Good',
    'Fair',
    'Poor',
    'Damaged'
  ];

  final List<String> _statusOptions = [
    'New',
    'In Use',
    'Maintenance',
    'Retired',
    'Disposed'
  ];

  @override
  void dispose() {
    _assetTagController.dispose();
    _serialNumberController.dispose();
    _locationController.dispose();
    _categoryController.dispose();
    _employeeIdController.dispose();
    _extNumberController.dispose();
    _faNumberController.dispose();
    _oldTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Asset'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: Container(
        color:
            context.lightMode ? AppColors.mintGreen : AppColors.darkMintGreen,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: context.lightMode ? AppColors.white : AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Enter / Scan Asset Tag'),
                  const SizedBox(height: 8),
                  _buildAssetTagField(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Enter / Scan Serial Number'),
                  const SizedBox(height: 8),
                  _buildSerialNumberField(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Insert/Take asset photo (Max 4)'),
                  const SizedBox(height: 8),
                  AssetPhotoSelector(
                    onPhotosChanged: (photos) {
                      setState(() {
                        _selectedPhotos = photos;
                      });
                    },
                    maxPhotos: 4,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Asset Condition'),
                  const SizedBox(height: 8),
                  CustomDropdownField(
                    value: _selectedCondition,
                    items: _conditionOptions,
                    onChanged: (value) {
                      setState(() {
                        _selectedCondition = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Asset Status'),
                  const SizedBox(height: 8),
                  CustomDropdownField(
                    value: _selectedStatus,
                    items: _statusOptions,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Location Details'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _locationController,
                    labelText: '',
                    fillColor: AppColors.textFieldLightYellow,
                    enabled: false,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Asset Category Description'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _categoryController,
                    labelText: '',
                    fillColor: AppColors.textFieldLightYellow,
                    enabled: false,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Employee ID'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _employeeIdController,
                              labelText: '',
                              fillColor: AppColors.textFieldLightYellow,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle('Ext. Number'),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: _extNumberController,
                              labelText: '',
                              fillColor: AppColors.textFieldLightYellow,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('FA Number'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _faNumberController,
                    labelText: '',
                    fillColor: AppColors.textFieldLightYellow,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Enter / Scan Old Tag'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _oldTagController,
                    labelText: '',
                    fillColor: AppColors.textFieldLightYellow,
                  ),
                  const SizedBox(height: 32),
                  CustomElecatedButton(
                    title: 'Save & Update',
                    backgroundColor: AppColors.primaryBlue,
                    onPressed: _handleSaveUpdate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: context.lightMode ? AppColors.primaryBlue : AppColors.white,
      ),
    );
  }

  Widget _buildAssetTagField() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _assetTagController,
            labelText: '',
            fillColor: AppColors.textFieldLightYellow,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: _scanAssetTag,
            icon: const Icon(
              Icons.qr_code_scanner,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSerialNumberField() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _serialNumberController,
            labelText: '',
            fillColor: AppColors.textFieldLightYellow,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: _scanSerialNumber,
            icon: const Icon(
              Icons.qr_code_scanner,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _scanAssetTag() {
    // TODO: Implement asset tag scanning
    print('Scanning asset tag...');
  }

  void _scanSerialNumber() {
    // TODO: Implement serial number scanning
    print('Scanning serial number...');
  }

  void _handleSaveUpdate() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save and update functionality
      print('Saving asset update...');
      print('Asset Tag: ${_assetTagController.text}');
      print('Serial Number: ${_serialNumberController.text}');
      print('Condition: $_selectedCondition');
      print('Status: $_selectedStatus');
      print('Photos: $_selectedPhotos');
      print('Employee ID: ${_employeeIdController.text}');
      print('Ext Number: ${_extNumberController.text}');
      print('FA Number: ${_faNumberController.text}');
      print('Old Tag: ${_oldTagController.text}');
    }
  }
}
