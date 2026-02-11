import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/presentation/screens/dashboard/widgets/appbar/logout_dialog_actons.dart';

class LogoutDialogContent extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const LogoutDialogContent({
    super.key,
    required this.isLoading,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.logout,
            color: isLoading ? unselectedColor : errorBgColor,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Text(
            'Logout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16, color: primaryColor),
          ),
          if (isLoading) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                successColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Logging out...',
              style: TextStyle(fontSize: 14, color: unselectedColor),
            ),
          ],
        ],
      ),
      actions: isLoading
          ? []
          : [
              LogoutDialogActions(
                onCancel: onCancel,
                onConfirm: onConfirm,
              ),
            ],
    );
  }
}