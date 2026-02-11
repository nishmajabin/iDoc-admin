import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/repositories/fee_slab_repository.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab/fee_slab_event.dart';
import 'package:idoc_admin_side/presentation/screens/fee_management/widgets/fee_management_view.dart';

class FeeManagementScreen extends StatelessWidget {
  const FeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeeSlabBloc(
        repository: FeeSlabRepository(),
      )..add(const LoadFeeSlabs()),
      child: const FeeManagementView(),
    );
  }
}