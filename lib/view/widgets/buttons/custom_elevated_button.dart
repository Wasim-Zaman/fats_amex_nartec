import 'package:fats_amex_nartec/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonState {
  normal,
  loading,
  disabled,
  success,
  error,
}

class CustomElecatedButton extends StatelessWidget {
  const CustomElecatedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.buttonState = ButtonState.normal,
  });

  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ButtonState? buttonState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonState == ButtonState.disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(),
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
        child: _buildChild(),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (buttonState) {
      case ButtonState.success:
        return AppColors.success;
      case ButtonState.error:
        return AppColors.error;
      case ButtonState.disabled:
        return Colors.grey;
      default:
        return backgroundColor ?? AppColors.primaryBlue;
    }
  }

  Widget _buildChild() {
    switch (buttonState) {
      case ButtonState.loading:
        return const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: AppColors.textLight,
            strokeWidth: 2,
            backgroundColor: AppColors.primaryBlue,
          ),
        );
      case ButtonState.success:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Success',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        );
      case ButtonState.error:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Error',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        );
      default:
        return Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        );
    }
  }
}
