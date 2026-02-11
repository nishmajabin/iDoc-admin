import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class InitializeDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const InitializeDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Initialize Default Fee Slabs'),
      content: const Text(
        'This will create default fee slabs:\n\n'
        '• 1-2 years: ₹200\n'
        '• 3-5 years: ₹350\n'
        '• 6-10 years: ₹500\n'
        '• 11+ years: ₹700\n\n'
        'Continue?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: const Text(
            'Initialize',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}