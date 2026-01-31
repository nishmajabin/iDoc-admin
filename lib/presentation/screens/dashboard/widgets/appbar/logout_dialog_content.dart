import 'package:flutter/material.dart';
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
            color: isLoading ? Colors.grey : Colors.red,
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
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          if (isLoading) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF6FCA78),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Logging out...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
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