import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCategoryImagePickerButton extends StatelessWidget {
  final Function(File?) onImagePicked;

  const EditCategoryImagePickerButton({
    Key? key,
    required this.onImagePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _pickImage,
      icon: const Icon(Icons.image),
      label: const Text('Change Image'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF4299E1),
        side: const BorderSide(color: Color(0xFF4299E1)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
}