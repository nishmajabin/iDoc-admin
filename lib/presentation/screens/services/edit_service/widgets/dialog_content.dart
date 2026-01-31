import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';
import 'package:idoc_admin_side/presentation/screens/services/edit_service/widgets/category_name_field.dart';
import 'package:idoc_admin_side/presentation/screens/services/edit_service/widgets/image_section.dart';


class EditCategoryDialogContent extends StatelessWidget {
  final TextEditingController nameController;
  final Department category;
  final File? newImage;
  final Function(File?) onImageUpdate;

  const EditCategoryDialogContent({
    Key? key,
    required this.nameController,
    required this.category,
    required this.newImage,
    required this.onImageUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditCategoryNameField(controller: nameController),
          const SizedBox(height: 20),
          EditCategoryImageSection(
            category: category,
            newImage: newImage,
            onImageUpdate: onImageUpdate,
          ),
        ],
      ),
    );
  }
}