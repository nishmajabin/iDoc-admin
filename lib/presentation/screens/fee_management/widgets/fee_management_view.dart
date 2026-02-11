import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_event.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_state.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/add_fee_slab/add_fee_slab_dialog.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/empty_state.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/fee_appbar.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/fee_list_content.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/fee_snackbar_listener.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/initialize_dialog.dart';


class FeeManagementView extends StatelessWidget {
  const FeeManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: FeeAppBar(onInitialize: () => _showInitializeDialog(context)),
      body: BlocConsumer<FeeSlabBloc, FeeSlabState>(
        listener: (context, state) => FeeSnackbarListener.show(context, state),
        builder: (context, state) {
          if (state is FeeSlabLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FeeSlabsLoaded) {
            return state.feeSlabs.isEmpty
                ? EmptyState(onAdd: () => _showAddFeeSlabDialog(context))
                : FeeListContent(feeSlabs: state.feeSlabs);
          }
          return EmptyState(onAdd: () => _showAddFeeSlabDialog(context));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddFeeSlabDialog(context),
        backgroundColor: primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Fee Slab',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showAddFeeSlabDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<FeeSlabBloc>(),
        child: const AddFeeSlabDialog(),
      ),
    );
  }

  void _showInitializeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => InitializeDialog(
        onConfirm: () {
          context.read<FeeSlabBloc>().add(const InitializeDefaultSlabs());
          Navigator.pop(dialogContext);
        },
      ),
    );
  }
}