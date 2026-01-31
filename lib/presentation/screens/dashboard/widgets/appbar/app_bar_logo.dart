import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/idoc_logo.png',
          height: 200,
          width: 200,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.local_hospital,
              color: Color(0xFF6FCA78),
              size: 32,
            );
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}