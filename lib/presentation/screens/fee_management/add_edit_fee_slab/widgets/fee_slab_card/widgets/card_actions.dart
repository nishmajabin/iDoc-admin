import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/edit_fee_slab/edit_fee_slab_dialog.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/widgets/delete_confirmation_dialog.dart';

class CardActions extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const CardActions({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit_outlined, color: Colors.blue.shade600),
          onPressed: () => _showEditDialog(context),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red.shade600),
          onPressed: () => _showDeleteDialog(context),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<FeeSlabBloc>(),
        child: EditFeeSlabDialog(feeSlab: feeSlab),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => DeleteConfirmationDialog(feeSlab: feeSlab),
    );
  }
}