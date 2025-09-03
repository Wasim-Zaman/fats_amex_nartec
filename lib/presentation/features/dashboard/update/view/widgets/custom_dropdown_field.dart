import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hint;
  final Color? fillColor;

  const CustomDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: hint != null ? Text(hint!) : null,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textDark,
              ),
            ),
          );
        }).toList(),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.primaryBlue,
        ),
        dropdownColor: AppColors.white,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
