import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class StatCardImage extends StatelessWidget {
  final String imageUrl;
  final Color color;
  final IconData icon;
  final bool isCompact;

  const StatCardImage({
    super.key,
    required this.imageUrl,
    required this.color,
    required this.icon,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCompact ? 200 : 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.1), bgColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ClipRRect(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: 2,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(icon, size: 60, color: color.withValues(alpha: 0.3)),
            );
          },
        ),
      ),
    );
  }
}