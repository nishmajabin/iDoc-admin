import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_state.dart';

class FeeSnackbarListener {
  static void show(BuildContext context, FeeSlabState state) {
    if (state is FeeSlabOperationSuccess) {
      _showSnackbar(
        context,
        message: state.message,
        icon: Icons.check_circle,
        iconColor: successColor,
        backgroundColor: bgColor,
      );
    } else if (state is FeeSlabError) {
      _showSnackbar(
        context,
        message: state.message,
        icon: Icons.error_outline,
        iconColor: buttonErrorColor,
        backgroundColor: bgColor,
      );
    }
  }

  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: TextStyle(color: primaryColor),)),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}