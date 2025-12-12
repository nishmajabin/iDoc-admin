import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/department.dart';
import 'package:idoc_admin_side/presentation/screens/services/edit_service/widgets/image_picker_button.dart';
import 'package:idoc_admin_side/presentation/screens/services/edit_service/widgets/image_preview.dart';

class EditCategoryImageSection extends StatelessWidget {
  final Department category;
  final File? newImage;
  final Function(File?) onImageUpdate;

  const EditCategoryImageSection({
    Key? key,
    required this.category,
    required this.newImage,
    required this.onImageUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditCategoryImagePreview(
          category: category,
          newImage: newImage,
          onClearImage: () => onImageUpdate(null),
        ),
        const SizedBox(height: 16),
        EditCategoryImagePickerButton(
          onImagePicked: onImageUpdate,
        ),
      ],
    );
  }
}