import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_event.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_state.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/add_category/add_category_button.dart';
import 'package:idoc_admin_side/presentation/screens/services/add_service/widgets/add_category/pick_image_button.dart';

class ActionButtons extends StatelessWidget {
  final File? selectedImage;
  final CategoryState state;
  final TextEditingController nameController;

  const ActionButtons({
    super.key,
    required this.selectedImage,
    required this.state,
    required this.nameController,
  });

  bool get _isUploading => state is CategoryUploading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: PickImageButton(selectedImage: selectedImage)),
        const SizedBox(width: 16),
        Expanded(
          child: AddCategoryButton(
            selectedImage: selectedImage,
            isUploading: _isUploading,
            onTap: () => _submit(context),
          ),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      _showSnackBar(context, 'Please enter a category name', Colors.orange);
      return;
    }

    if (selectedImage == null) return;

    context.read<CategoryBloc>().add(
          AddCategoryEvent(name: name, image: selectedImage!),
        );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}
