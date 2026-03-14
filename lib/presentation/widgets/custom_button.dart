import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final double height;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.height = 65,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: navBoxColor.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonbgColor,
          elevation: 0,
          shadowColor: transparentColor,
          foregroundColor: whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: const BorderSide(
              color: borderColor,
              width: 4,
            ),
          ),
          disabledBackgroundColor: primaryColor,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
                  strokeWidth: 1,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }
}