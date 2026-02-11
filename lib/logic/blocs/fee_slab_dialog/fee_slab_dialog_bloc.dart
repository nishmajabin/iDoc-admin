import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_event.dart';
import 'package:idoc_admin_side/logic/blocs/fee_slab_dialog/fee_slab_dialog_state.dart';

class FeeSlabDialogBloc extends Bloc<FeeSlabDialogEvent, FeeSlabDialogState> {
  FeeSlabDialogBloc() : super(const FeeSlabDialogState()) {
    on<ToggleUnlimitedEvent>(_onToggleUnlimited);
    on<InitializeEditMode>(_onInitializeEditMode);
  }

  void _onToggleUnlimited(
    ToggleUnlimitedEvent event,
    Emitter<FeeSlabDialogState> emit,
  ) {
    emit(state.copyWith(isUnlimited: !state.isUnlimited));
  }

  // NEW HANDLER - Add this to handle edit mode initialization
  void _onInitializeEditMode(
    InitializeEditMode event,
    Emitter<FeeSlabDialogState> emit,
  ) {
    emit(state.copyWith(isUnlimited: event.isUnlimited));
  }
}