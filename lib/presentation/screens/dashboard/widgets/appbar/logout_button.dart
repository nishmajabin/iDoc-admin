import 'package:flutter/material.dart';

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
        icon: const Icon(Icons.logout, color: Colors.red, size: 26),
        onPressed: onPressed,
        tooltip: 'Logout',
        splashRadius: 24,
      ),
    );
  }
}