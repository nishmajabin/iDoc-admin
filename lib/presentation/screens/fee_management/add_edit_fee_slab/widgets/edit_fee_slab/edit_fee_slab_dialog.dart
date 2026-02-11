import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_event.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/edit_fee_slab/widgets/edit_dialog_content.dart';

class EditFeeSlabDialog extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const EditFeeSlabDialog({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeeSlabDialogBloc()
        ..add(InitializeEditMode(
          isUnlimited: feeSlab.maxExperience >= 100,
        )),
      child: EditDialogContent(feeSlab: feeSlab),
    );
  }
}