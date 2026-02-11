import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class StatRowWidget extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const StatRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: bgColor.withValues(alpha: 0.9), size: 20),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: bgColor.withValues(alpha: 0.9),
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: bgColor,
            ),
          ),
        ),
      ],
    );
  }
}