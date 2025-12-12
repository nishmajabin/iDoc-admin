import 'package:flutter/material.dart';

class EditCategoryNameField extends StatelessWidget {
  final TextEditingController controller;

  const EditCategoryNameField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Category Name',
        hintText: 'Enter category name',
        prefixIcon: const Icon(
          Icons.category,
          color: Color(0xFF4299E1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF4299E1),
            width: 2,
          ),
        ),
      ),
    );
  }
}