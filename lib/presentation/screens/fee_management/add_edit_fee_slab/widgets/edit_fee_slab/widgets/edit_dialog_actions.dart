import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_event.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_state.dart';

class EditDialogActions extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FeeSlabModel feeSlab;
  final TextEditingController minExpController;
  final TextEditingController maxExpController;
  final TextEditingController feeController;

  const EditDialogActions({
    super.key,
    required this.formKey,
    required this.feeSlab,
    required this.minExpController,
    required this.maxExpController,
    required this.feeController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BlocBuilder<FeeSlabDialogBloc, FeeSlabDialogState>(
            builder: (context, state) => ElevatedButton(
              onPressed: () => _handleSubmit(context, state.isUnlimited),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Update',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context, bool isUnlimited) {
    if (formKey.currentState!.validate()) {
      final updatedSlab = feeSlab.copyWith(
        minExperience: int.parse(minExpController.text),
        maxExperience: isUnlimited ? 999 : int.parse(maxExpController.text),
        consultationFee: double.parse(feeController.text),
        updatedAt: DateTime.now(),
      );

      context.read<FeeSlabBloc>().add(UpdateFeeSlab(updatedSlab));
      Navigator.pop(context);
    }
  }
}