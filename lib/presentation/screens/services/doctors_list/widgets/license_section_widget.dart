import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LicenseSectionWidget extends StatelessWidget {
  final String licenseFileUrl;

  const LicenseSectionWidget({
    Key? key,
    required this.licenseFileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPdf = licenseFileUrl.toLowerCase().endsWith('.pdf');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6FCA78).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6FCA78).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 20,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'License Document',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isPdf) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                licenseFileUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF6FCA78),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 40),
                        SizedBox(height: 8),
                        Text('Failed to load image'),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
          ElevatedButton.icon(
            onPressed: () => _openLicenseFile(context, licenseFileUrl),
            icon: Icon(isPdf ? Icons.picture_as_pdf : Icons.open_in_new),
            label: Text(isPdf ? 'View PDF Document' : 'View Full Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6FCA78),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLicenseFile(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open license document'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}