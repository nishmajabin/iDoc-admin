import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_state.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/widgets/unlimited_checkbox.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/custom_slab_text_field.dart';

class FormFields extends StatelessWidget {
  final TextEditingController minExpController;
  final TextEditingController maxExpController;
  final TextEditingController feeController;

  const FormFields({
    super.key,
    required this.minExpController,
    required this.maxExpController,
    required this.feeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: minExpController,
          label: 'Minimum Experience (years)',
          hint: 'e.g., 1',
          validator: _validateMinExp,
        ),
        const SizedBox(height: 16),
        BlocBuilder<FeeSlabDialogBloc, FeeSlabDialogState>(
          builder: (context, state) => CustomTextField(
            controller: maxExpController,
            label: 'Maximum Experience (years)',
            hint: 'e.g., 5',
            enabled: !state.isUnlimited,
            validator: (value) => _validateMaxExp(value, state.isUnlimited),
          ),
        ),
        const SizedBox(height: 8),
        UnlimitedCheckbox(maxExpController: maxExpController),
        const SizedBox(height: 16),
        CustomTextField(
          controller: feeController,
          label: 'Consultation Fee (₹)',
          hint: 'e.g., 350',
          validator: _validateFee,
        ),
      ],
    );
  }

  String? _validateMinExp(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    final num = int.tryParse(value);
    if (num == null || num < 0) return 'Invalid number';
    return null;
  }

  String? _validateMaxExp(String? value, bool isUnlimited) {
    if (isUnlimited) return null;
    if (value == null || value.isEmpty) return 'Required';
    final num = int.tryParse(value);
    if (num == null || num < 0) return 'Invalid number';
    final minExp = int.tryParse(minExpController.text);
    if (minExp != null && num < minExp) return 'Must be ≥ minimum';
    return null;
  }

  String? _validateFee(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    final num = double.tryParse(value);
    if (num == null || num <= 0) return 'Invalid amount';
    return null;
  }
}