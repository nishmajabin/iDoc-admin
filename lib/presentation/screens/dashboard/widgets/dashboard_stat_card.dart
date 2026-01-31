import 'package:flutter/material.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/stat_card_content.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/stat_image_section.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final int total;
  final int? male;
  final int? female;
  final Color color;
  final IconData icon;
  final String imageUrl;
  final bool showGenderBreakdown;

  const StatCardWidget({
    super.key,
    required this.title,
    required this.total,
    this.male,
    this.female,
    required this.color,
    required this.icon,
    required this.imageUrl,
    this.showGenderBreakdown = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: StatCardContent(
                title: title,
                icon: icon,
                total: total,
                male: male,
                female: female,
                color: color,
                showGenderBreakdown: showGenderBreakdown,
              ),
            ),
            Expanded(
              flex: 2,
              child: StatCardImage(
                imageUrl: imageUrl,
                color: color,
                icon: icon,
                isCompact: !showGenderBreakdown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}