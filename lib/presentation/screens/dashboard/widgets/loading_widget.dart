import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            strokeWidth: 1,
          ),
          SizedBox(height: 16),
          Text(
            'Loading dashboard...',
            style: TextStyle(color: Color(0xFF718096), fontSize: 14),
          ),
        ],
      ),
    );
  }
}