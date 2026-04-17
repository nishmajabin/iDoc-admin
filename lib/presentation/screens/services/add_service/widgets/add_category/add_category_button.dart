import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';

class AddCategoryButton extends StatelessWidget {
  final File? selectedImage;
  final bool isUploading;
  final VoidCallback onTap;

  const AddCategoryButton({
    required this.selectedImage,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: (selectedImage == null || isUploading) ? null : onTap,
      icon: isUploading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Icon(Icons.add_rounded),
      label: Text(
        isUploading ? 'Adding...' : 'Add Category',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        disabledBackgroundColor: Colors.grey.shade300,
      ),
    );
  }
}