import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_event.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const DeleteConfirmationDialog({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Fee Slab'),
      content: Text(
        'Are you sure you want to delete the fee slab for ${feeSlab.experienceRange}?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<FeeSlabBloc>().add(DeleteFeeSlab(feeSlab.id!));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}