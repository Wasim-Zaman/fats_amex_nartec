import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElecatedButton extends StatelessWidget {
  const CustomElecatedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    // this.isLoading = true,
  });

  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryBlue,
        foregroundColor: foregroundColor ?? AppColors.textLight,
        minimumSize: const Size(double.infinity, 48),
        maximumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        child: isLoading == true
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppColors.textLight,
                  strokeWidth: 2,
                  backgroundColor: AppColors.primaryBlue,
                ),
              )
            : Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
