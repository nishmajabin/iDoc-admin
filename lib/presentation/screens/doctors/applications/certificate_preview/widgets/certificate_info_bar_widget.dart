import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class CertificateInfoBarWidget extends StatelessWidget {
  const CertificateInfoBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [blackColor, blackColor.withValues(alpha: 0)],
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pinch_outlined,
              color: bgColor.withValues(alpha: 0.6),
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'Pinch to zoom • Drag to pan',
              style: TextStyle(
                color: bgColor.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
