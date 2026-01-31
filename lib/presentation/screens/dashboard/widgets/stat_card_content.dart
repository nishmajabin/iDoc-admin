import 'package:flutter/material.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/stat_row.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/stat_card_header.dart';

class StatCardContent extends StatelessWidget {
  final String title;
  final IconData icon;
  final int total;
  final int? male;
  final int? female;
  final Color color;
  final bool showGenderBreakdown;

  const StatCardContent({
    super.key,
    required this.title,
    required this.icon,
    required this.total,
    this.male,
    this.female,
    required this.color,
    required this.showGenderBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.9), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatCardHeader(title: title, icon: icon),
          const SizedBox(height: 24),
          StatRowWidget(label: 'TOTAL', value: total, icon: Icons.groups),
          if (showGenderBreakdown && male != null && female != null) ...[
            const SizedBox(height: 16),
            StatRowWidget(label: 'MALE', value: male!, icon: Icons.man),
            const SizedBox(height: 16),
            StatRowWidget(label: 'FEMALE', value: female!, icon: Icons.woman),
          ],
        ],
      ),
    );
  }
}