import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_event.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_state.dart';

class UnlimitedCheckbox extends StatelessWidget {
  final TextEditingController maxExpController;

  const UnlimitedCheckbox({super.key, required this.maxExpController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeeSlabDialogBloc, FeeSlabDialogState>(
      builder: (context, state) => CheckboxListTile(
        value: state.isUnlimited,
        onChanged: (value) {
          context.read<FeeSlabDialogBloc>().add(const ToggleUnlimitedEvent());
          maxExpController.text = (value == true) ? '999' : '';
        },
        title: Text(
          'Unlimited (e.g., 10+ years)',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
