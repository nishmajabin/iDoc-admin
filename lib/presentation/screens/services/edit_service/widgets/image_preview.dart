import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';

class EditCategoryImagePreview extends StatelessWidget {
  final Department category;
  final File? newImage;
  final VoidCallback onClearImage;

  const EditCategoryImagePreview({
    Key? key,
    required this.category,
    required this.newImage,
    required this.onClearImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: newImage != null
            ? _buildLocalImagePreview()
            : _buildNetworkImagePreview(),
      ),
    );
  }

  Widget _buildLocalImagePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          newImage!,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: _buildClearButton(),
        ),
      ],
    );
  }

  Widget _buildNetworkImagePreview() {
    return Image.network(
      category.image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.error, color: Colors.red),
        );
      },
    );
  }

  Widget _buildClearButton() {
    return IconButton(
      onPressed: onClearImage,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}