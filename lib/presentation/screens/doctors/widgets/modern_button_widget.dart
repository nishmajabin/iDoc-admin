import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class ModernButtonWidget extends StatelessWidget {
  const ModernButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient:
                isPrimary
                    ? LinearGradient(colors: [primaryColor, gradientColor])
                    : null,
            color: isPrimary ? null : errorBoxColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary ? buttonBorderColor: errorOutlineColor,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary ? bgColor : buttonErrorColor,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isPrimary ? bgColor : buttonErrorColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
