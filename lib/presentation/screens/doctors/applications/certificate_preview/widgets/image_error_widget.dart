import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image_outlined, size: 64, color: Colors.white54),
            SizedBox(height: 16),
            Text(
              'Failed to load image',
              style: TextStyle(color: imageErrorTextColor, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Please check your connection',
              style: TextStyle(color: imageErrorTextColor2, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
