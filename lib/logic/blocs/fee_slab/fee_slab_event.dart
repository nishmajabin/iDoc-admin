import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';

abstract class FeeSlabEvent extends Equatable {
  const FeeSlabEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeeSlabs extends FeeSlabEvent {
  const LoadFeeSlabs();
}

class CreateFeeSlab extends FeeSlabEvent {
  final int minExperience;
  final int maxExperience;
  final double consultationFee;

  const CreateFeeSlab({
    required this.minExperience,
    required this.maxExperience,
    required this.consultationFee,
  });

  @override
  List<Object?> get props => [minExperience, maxExperience, consultationFee];
}

class UpdateFeeSlab extends FeeSlabEvent {
  final FeeSlabModel feeSlab;

  const UpdateFeeSlab(this.feeSlab);

  @override
  List<Object?> get props => [feeSlab];
}

class DeleteFeeSlab extends FeeSlabEvent {
  final String slabId;

  const DeleteFeeSlab(this.slabId);

  @override
  List<Object?> get props => [slabId];
}

class InitializeDefaultSlabs extends FeeSlabEvent {
  const InitializeDefaultSlabs();
}