import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/certificate_preview/widgets/certificate_info_bar_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/certificate_preview/widgets/image_error_widget.dart';
import 'package:idoc_admin_side/presentation/screens/doctors/applications/certificate_preview/widgets/image_loading_widget.dart';

class CertificatePreviewPage extends StatelessWidget {
  const CertificatePreviewPage({
    super.key,
    required this.heading,
    required this.imageUrl,
  });

  final String heading;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: bgColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: const Icon(Icons.close, color: bgColor, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          heading,
          style: const TextStyle(
            color: bgColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withValues(alpha: 0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ImageLoadingWidget(loadingProgress: loadingProgress);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const ImageErrorWidget();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CertificateInfoBarWidget(),
    );
  }
}
