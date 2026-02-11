import 'package:flutter/material.dart';

class FeeSlabIcon extends StatelessWidget {
  const FeeSlabIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.account_balance_wallet,
        color: Colors.blue.shade700,
        size: 28,
      ),
    );
  }
}