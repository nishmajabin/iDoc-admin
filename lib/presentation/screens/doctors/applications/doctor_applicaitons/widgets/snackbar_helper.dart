import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class SnackBarHelper {
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: successColor),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: TextStyle(color: primaryColor),)),
          ],
        ),
        backgroundColor: brColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: buttonErrorColor),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: (TextStyle(color: primaryColor)))),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
