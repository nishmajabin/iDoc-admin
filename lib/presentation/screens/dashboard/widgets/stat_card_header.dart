import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class StatCardHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const StatCardHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: bgColor, size: 24),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: bgColor,
            ),
          ),
        ),
      ],
    );
  }
}