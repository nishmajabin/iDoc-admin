import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';

abstract class FeeSlabState extends Equatable {
  const FeeSlabState();

  @override
  List<Object?> get props => [];
}

class FeeSlabInitial extends FeeSlabState {
  const FeeSlabInitial();
}

class FeeSlabLoading extends FeeSlabState {
  const FeeSlabLoading();
}

class FeeSlabsLoaded extends FeeSlabState {
  final List<FeeSlabModel> feeSlabs;

  const FeeSlabsLoaded({required this.feeSlabs});

  @override
  List<Object?> get props => [feeSlabs];
}

class FeeSlabOperationSuccess extends FeeSlabState {
  final String message;

  const FeeSlabOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class FeeSlabError extends FeeSlabState {
  final String message;

  const FeeSlabError({required this.message});

  @override
  List<Object?> get props => [message];
}