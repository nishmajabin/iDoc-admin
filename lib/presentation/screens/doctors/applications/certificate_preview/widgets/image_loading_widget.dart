import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class ImageLoadingWidget extends StatelessWidget {
  const ImageLoadingWidget({super.key, required this.loadingProgress});

  final ImageChunkEvent? loadingProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value:
                  loadingProgress?.expectedTotalBytes != null
                      ? loadingProgress!.cumulativeBytesLoaded /
                          loadingProgress!.expectedTotalBytes!
                      : null,
              valueColor: const AlwaysStoppedAnimation<Color>(bgColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading image...',
              style: TextStyle(color: imageErrorTextColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
