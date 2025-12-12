import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_state.dart';
import 'image_preview.dart';
import 'action_buttons.dart';

class ImageSection extends StatelessWidget {
  final TextEditingController nameController;

  const ImageSection({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        File? image;

        if (state is CategoryImagePicked) {
          image = state.image;
        } else if (state is CategoryLoaded) {
          image = state.selectedImage;
        }

        return Column(
          children: [
            if (image != null) ...[
              ImagePreview(image: image),
              const SizedBox(height: 16),
            ],
            ActionButtons(
              selectedImage: image,
              state: state,
              nameController: nameController,
            ),
          ],
        );
      },
    );
  }
}
