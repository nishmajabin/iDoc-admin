import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_event.dart';

class PickImageButton extends StatelessWidget {
  final File? selectedImage;
  const PickImageButton({required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () =>
          context.read<CategoryBloc>().add(const PickImageEvent()),
      icon: const Icon(Icons.image),
      label: Text(selectedImage != null ? 'Change Image' : 'Pick Image'),
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor.withValues(alpha: 0.3)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
