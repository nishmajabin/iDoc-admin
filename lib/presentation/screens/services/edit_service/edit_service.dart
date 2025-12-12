import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/department.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_event.dart';
import 'package:idoc_admin_side/presentation/screens/services/edit_service/widgets/dialog_content.dart';

void showEditCategoryDialog(BuildContext context, Department category) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return EditCategoryDialog(category: category);
    },
  );
}

class EditCategoryDialog extends StatefulWidget {
  final Department category;

  const EditCategoryDialog({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late TextEditingController _nameController;
  File? _newImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _updateImage(File? image) {
    setState(() {
      _newImage = image;
    });
  }

  void _handleSave(BuildContext context) {
    final newName = _nameController.text.trim();

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a category name'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<CategoryBloc>().add(
          UpdateCategoryEvent(
            docId: widget.category.id,
            name: newName,
            newImage: _newImage,
            currentImageUrl: widget.category.image,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: _buildDialogTitle(),
      content: EditCategoryDialogContent(
        nameController: _nameController,
        category: widget.category,
        newImage: _newImage,
        onImageUpdate: _updateImage,
      ),
      actions: _buildActions(context),
    );
  }

  Widget _buildDialogTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4299E1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.edit,
            color: Color(0xFF4299E1),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Edit Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
      ElevatedButton.icon(
        onPressed: () => _handleSave(context),
        icon: const Icon(Icons.save),
        label: const Text(
          'Save',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4299E1),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ];
  }
}