import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: IconButton(
        icon: const Icon(Icons.logout, color: errorBgColor, size: 26),
        onPressed: onPressed,
        tooltip: 'Logout',
        splashRadius: 24,
      ),
    );
  }
}