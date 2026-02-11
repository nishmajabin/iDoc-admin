import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/widgets/dialog_content.dart';

class AddFeeSlabDialog extends StatelessWidget {
  const AddFeeSlabDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeeSlabDialogBloc(),
      child: const DialogContent(),
    );
  }
}