import 'package:flutter/material.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/edit_fee_slab/widgets/edit_dialog_actions.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/edit_fee_slab/widgets/edit_dialog_header.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/edit_fee_slab/widgets/edit_form_fileds.dart';

class EditDialogContent extends StatelessWidget {
  final FeeSlabModel feeSlab;

  const EditDialogContent({super.key, required this.feeSlab});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final minExpController = TextEditingController(
      text: feeSlab.minExperience.toString(),
    );
    final maxExpController = TextEditingController(
      text: feeSlab.maxExperience.toString(),
    );
    final feeController = TextEditingController(
      text: feeSlab.consultationFee.toStringAsFixed(0),
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EditDialogHeader(),
                const SizedBox(height: 24),
                EditFormFields(
                  minExpController: minExpController,
                  maxExpController: maxExpController,
                  feeController: feeController,
                ),
                const SizedBox(height: 24),
                EditDialogActions(
                  formKey: formKey,
                  feeSlab: feeSlab,
                  minExpController: minExpController,
                  maxExpController: maxExpController,
                  feeController: feeController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}