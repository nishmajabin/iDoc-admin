import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard Overview',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: dashboardTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Real-time statistics',
          style: TextStyle(fontSize: 14, color: unselectedColor),
        ),
      ],
    );
  }
}