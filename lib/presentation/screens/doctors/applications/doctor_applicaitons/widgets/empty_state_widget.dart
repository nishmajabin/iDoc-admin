import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: emptyContainerColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 64,
              color: blueColor,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "No Pending Applications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "All applications have been processed",
            style: TextStyle(fontSize: 14, color: unselectedColor),
          ),
        ],
      ),
    );
  }
}
