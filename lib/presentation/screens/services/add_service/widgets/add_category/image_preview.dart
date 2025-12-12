import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/department/department_event.dart';

class ImagePreview extends StatelessWidget {
  final File image;

  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(image, fit: BoxFit.cover),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: () {
                  context.read<CategoryBloc>().add(const ClearImageEvent());
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
