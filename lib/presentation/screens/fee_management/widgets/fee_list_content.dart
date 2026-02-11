import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_event.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/add_edit_fee_slab/widgets/fee_slab_card/fee_slab_card.dart';

class FeeListContent extends StatelessWidget {
  final List<FeeSlabModel> feeSlabs;

  const FeeListContent({super.key, required this.feeSlabs});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FeeSlabBloc>().add(const LoadFeeSlabs());
      },
      color: Colors.blue.shade600,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: feeSlabs.length + 1,
        itemBuilder: (context, index) {
          if (index == feeSlabs.length) {
            return const SizedBox(height: 80);
          }
          return FeeSlabCard(feeSlab: feeSlabs[index]);
        },
      ),
    );
  }
}