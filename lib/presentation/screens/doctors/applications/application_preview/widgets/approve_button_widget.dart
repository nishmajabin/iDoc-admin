import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class ApproveButtonWidget extends StatelessWidget {
  const ApproveButtonWidget({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.isApproved = false,
  });

  final bool isLoading;
  final VoidCallback? onPressed;
  final bool isApproved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isApproved
              ? _buildApprovedButton()
              : _buildApproveButton(),
    );
  }

  Widget _buildApprovedButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: scaffoldSuccessColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scaffoldSuccessColor,
          width: 2,
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: scaffoldSuccessColor, size: 24),
          SizedBox(width: 12),
          Text(
            "APPROVED",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scaffoldSuccessColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApproveButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ).copyWith(
        backgroundColor: WidgetStateProperty.all(transparentColor),
        shadowColor: WidgetStateProperty.all(transparentColor),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [approveGradientClr1, approveGradientClr2],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline, color: bgColor),
              SizedBox(width: 12),
              Text(
                "APPROVE APPLICATION",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: bgColor,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}