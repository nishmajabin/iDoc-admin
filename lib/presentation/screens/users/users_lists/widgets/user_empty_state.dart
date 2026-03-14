
import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class UserEmptyState extends StatelessWidget {
  final String? searchQuery;

  const UserEmptyState({
    super.key,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: subtitleColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery != null && searchQuery!.isNotEmpty
                ? 'No users found'
                : 'No users yet',
            style: TextStyle(
              color: subtitleColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}