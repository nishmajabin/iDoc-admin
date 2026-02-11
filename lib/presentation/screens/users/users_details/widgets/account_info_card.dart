import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/info_row_widget.dart';
import 'package:intl/intl.dart';

class AccountInfoCard extends StatelessWidget {
  final UserModel user;

  const AccountInfoCard({
    super.key,
    required this.user,
  });

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: blackColor.withValues(alpha:0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Account Created',
            value: _formatDateTime(user.createdAt),
          ),
          const Divider(height: 24),
          InfoRow(
            icon: Icons.login_outlined,
            label: 'Last Login',
            value: _formatDateTime(user.lastLoginAt),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: gradientColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.history,
            color: gradientColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Account Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: dashboardTextColor,
          ),
        ),
      ],
    );
  }
}