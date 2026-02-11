import 'package:flutter/material.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/widgets/dialog_actions.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/widgets/dialog_header.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/widgets/form_fields.dart';


class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final minExpController = TextEditingController();
    final maxExpController = TextEditingController();
    final feeController = TextEditingController();

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
                const DialogHeader(),
                const SizedBox(height: 24),
                FormFields(
                  minExpController: minExpController,
                  maxExpController: maxExpController,
                  feeController: feeController,
                ),
                const SizedBox(height: 24),
                DialogActions(
                  formKey: formKey,
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