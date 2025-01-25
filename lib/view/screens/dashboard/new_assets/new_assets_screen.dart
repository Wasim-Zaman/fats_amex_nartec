import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:fats_amex_nartec/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/snack_util.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class NewAssetsScreen extends ConsumerStatefulWidget {
  const NewAssetsScreen({super.key});

  @override
  ConsumerState<NewAssetsScreen> createState() => _NewAssetsScreenState();
}

class _NewAssetsScreenState extends ConsumerState<NewAssetsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _locationController = TextEditingController();
  final _assetCategoryController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _quantityController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _extensionController = TextEditingController();
  final _faNumberController = TextEditingController();
  final _oldTagController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    _assetCategoryController.dispose();
    _serialNumberController.dispose();
    _quantityController.dispose();
    _employeeIdController.dispose();
    _extensionController.dispose();
    _faNumberController.dispose();
    _oldTagController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement save functionality
      SnackUtil.showSuccess(context, 'Asset saved successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Assets'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _locationController,
                labelText: 'Location',
                prefixIcon: Icons.location_on,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _assetCategoryController,
                fillColor: context.lightMode
                    ? AppColors.textFieldLightYellow
                    : AppColors.secondaryBlue,
                labelText: 'Asset Category Description',
                prefixIcon: Icons.category,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: () {},
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter asset category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _serialNumberController,
                labelText: 'Enter / Scan Serial Number',
                prefixIcon: Icons.qr_code,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter serial number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _quantityController,
                labelText: 'Enter Asset Qty',
                prefixIcon: Icons.numbers,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _employeeIdController,
                      labelText: 'Employee ID',
                      prefixIcon: Icons.badge,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter ID';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _extensionController,
                      labelText: 'Ext. Number',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter ext.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _faNumberController,
                labelText: 'FA Number',
                prefixIcon: Icons.tag,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter FA number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _oldTagController,
                labelText: 'Enter / Scan Old Tag',
                prefixIcon: Icons.qr_code_scanner,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter old tag';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomElecatedButton(
                title: 'Save',
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
