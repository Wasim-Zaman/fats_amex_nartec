import 'package:fats_amex_nartec/core/extensions/context.dart';
import 'package:fats_amex_nartec/router/app_navigator.dart';
import 'package:fats_amex_nartec/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/snack_util.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../widgets/text_fields/custom_text_field.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _buildingController = TextEditingController();
  final _levelController = TextEditingController();
  final _officeController = TextEditingController();
  final _roomController = TextEditingController();
  late final TextEditingController _locationCodeController;

  @override
  void initState() {
    super.initState();
    _locationCodeController = TextEditingController();
    // Add listeners to update location code
    _companyController.addListener(_updateLocationCode);
    _buildingController.addListener(_updateLocationCode);
    _levelController.addListener(_updateLocationCode);
    _officeController.addListener(_updateLocationCode);
    _roomController.addListener(_updateLocationCode);
  }

  void _updateLocationCode() {
    final locationCode = [
      _companyController.text,
      _buildingController.text,
      _levelController.text,
      _officeController.text,
      _roomController.text,
    ].where((element) => element.isNotEmpty).join('-');
    _locationCodeController.text = locationCode;
  }

  @override
  void dispose() {
    _companyController.dispose();
    _buildingController.dispose();
    _levelController.dispose();
    _officeController.dispose();
    _roomController.dispose();
    _locationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: context.lightMode
                  ? AppColors.white
                  : AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24,
                  children: [
                    const Text(
                      'Create Asset Tag Locations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 16,
                      children: [
                        _buildLabeledTextField(
                          label: 'Company',
                          controller: _companyController,
                        ),
                        _buildLabeledTextField(
                          label: 'Building',
                          controller: _buildingController,
                        ),
                        _buildLabeledTextField(
                          label: 'Level',
                          controller: _levelController,
                        ),
                        _buildLabeledTextField(
                          label: 'Office',
                          controller: _officeController,
                        ),
                        _buildLabeledTextField(
                          label: 'Room',
                          controller: _roomController,
                        ),
                        _buildLabeledTextField(
                          label: 'Loc_code',
                          controller: _locationCodeController,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: CustomElecatedButton(
                            title: 'Save',
                            onPressed: _handleSave,
                          ),
                        ),
                        Expanded(
                          child: CustomElecatedButton(
                            title: 'Preview/Print Tag',
                            onPressed: _handlePreviewTag,
                          ),
                        ),
                      ],
                    ),
                    CustomElecatedButton(
                      title: 'View Assets Locations',
                      onPressed: _handleViewLocations,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          labelText: '',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save functionality
      SnackUtil.showSuccess(context, 'Save Successfully');
    }
  }

  void _handlePreviewTag() {
    // TODO: Implement preview/print tag functionality
  }

  void _handleViewLocations() {
    AppNavigator.push(context, AppRoutes.assetsLocation);
  }
}
