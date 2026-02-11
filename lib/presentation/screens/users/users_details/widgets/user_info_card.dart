import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/info_row_widget.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel user;

  const UserInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: blackColor.withValues(alpha: 0.08),
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
            icon: Icons.person_outline,
            label: 'Full Name',
            value: user.name,
          ),
          if (user.address != null && user.address!.isNotEmpty) ...[
            const Divider(height: 24),
            InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Address',
              value: user.address!,
              valueColor: locationColor,
            ),
          ],
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
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.person_outline,
            color: primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Personal Information',
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