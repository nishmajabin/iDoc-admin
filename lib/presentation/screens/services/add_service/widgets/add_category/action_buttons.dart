import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_event.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_state.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              context.read<CategoryBloc>().add(const PickImageEvent());
            },
            icon: const Icon(Icons.image),
            label: Text(selectedImage != null ? 'Change Image' : 'Pick Image'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor.withValues(alpha: 0.3)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                selectedImage == null
                    ? null
                    : () => _addCategory(context, selectedImage!),
            icon:
                state is CategoryUploading
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
              state is CategoryUploading ? 'Adding...' : 'Add Category',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }

  void _addCategory(BuildContext context, File image) {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a category name'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<CategoryBloc>().add(
      AddCategoryEvent(name: nameController.text.trim(), image: image),
    );
  }
}
