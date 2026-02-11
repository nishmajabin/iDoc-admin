import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/presentation/screens/users/users_details/widgets/info_row_widget.dart';

class ContactInfoCard extends StatelessWidget {
  final UserModel user;

  const ContactInfoCard({
    super.key,
    required this.user,
  });

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
            icon: Icons.email_outlined,
            label: 'Email',
            value: user.email,
          ),
          if (user.mobileNumber != null && user.mobileNumber!.isNotEmpty) ...[
            const Divider(height: 24),
            InfoRow(
              icon: Icons.phone_outlined,
              label: 'Mobile Number',
              value: user.mobileNumber!,
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
            color: locationColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.contact_mail_outlined,
            color: locationColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Contact Information',
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