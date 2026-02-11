// Add this event to your existing fee_slab_dialog_event.dart file

import 'package:equatable/equatable.dart';

abstract class FeeSlabDialogEvent extends Equatable {
  const FeeSlabDialogEvent();

  @override
  List<Object?> get props => [];
}

class ToggleUnlimitedEvent extends FeeSlabDialogEvent {
  const ToggleUnlimitedEvent();
}

class InitializeEditMode extends FeeSlabDialogEvent {
  final bool isUnlimited;

  const InitializeEditMode({required this.isUnlimited});

  @override
  List<Object?> get props => [isUnlimited];
}