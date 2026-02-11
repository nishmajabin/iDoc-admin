import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';
import 'package:idoc_admin_side/data/repositories/fee_slab_repository.dart';
import 'fee_slab_event.dart';
import 'fee_slab_state.dart';

class FeeSlabBloc extends Bloc<FeeSlabEvent, FeeSlabState> {
  final FeeSlabRepository repository;
  StreamSubscription<List<FeeSlabModel>>? _feeSlabsSubscription;

  FeeSlabBloc({required this.repository}) : super(const FeeSlabInitial()) {
    on<LoadFeeSlabs>(_onLoadFeeSlabs);
    on<CreateFeeSlab>(_onCreateFeeSlab);
    on<UpdateFeeSlab>(_onUpdateFeeSlab);
    on<DeleteFeeSlab>(_onDeleteFeeSlab);
    on<InitializeDefaultSlabs>(_onInitializeDefaultSlabs);
    on<_FeeSlabsUpdated>(_onFeeSlabsUpdated);
  }

  Future<void> _onLoadFeeSlabs(
    LoadFeeSlabs event,
    Emitter<FeeSlabState> emit,
  ) async {
    emit(const FeeSlabLoading());

    await _feeSlabsSubscription?.cancel();

    _feeSlabsSubscription = repository.getFeeSlabsStream().listen(
      (feeSlabs) {
        add(_FeeSlabsUpdated(feeSlabs));
      },
      onError: (error) {
        emit(FeeSlabError(message: error.toString()));
      },
    );
  }

  Future<void> _onFeeSlabsUpdated(
    _FeeSlabsUpdated event,
    Emitter<FeeSlabState> emit,
  ) async {
    emit(FeeSlabsLoaded(feeSlabs: event.feeSlabs));
  }

  Future<void> _onCreateFeeSlab(
    CreateFeeSlab event,
    Emitter<FeeSlabState> emit,
  ) async {
    try {
      emit(const FeeSlabLoading());

      final feeSlab = FeeSlabModel(
        minExperience: event.minExperience,
        maxExperience: event.maxExperience,
        consultationFee: event.consultationFee,
      );

      await repository.createFeeSlab(feeSlab);

      emit(const FeeSlabOperationSuccess(
        message: 'Fee slab created successfully',
      ));

      add(const LoadFeeSlabs());
    } catch (e) {
      emit(FeeSlabError(message: e.toString()));
    }
  }

  Future<void> _onUpdateFeeSlab(
    UpdateFeeSlab event,
    Emitter<FeeSlabState> emit,
  ) async {
    try {
      emit(const FeeSlabLoading());

      await repository.updateFeeSlab(event.feeSlab);

      emit(const FeeSlabOperationSuccess(
        message: 'Fee slab updated successfully',
      ));

      add(const LoadFeeSlabs());
    } catch (e) {
      emit(FeeSlabError(message: e.toString()));
    }
  }

  Future<void> _onDeleteFeeSlab(
    DeleteFeeSlab event,
    Emitter<FeeSlabState> emit,
  ) async {
    try {
      emit(const FeeSlabLoading());

      await repository.deleteFeeSlab(event.slabId);

      emit(const FeeSlabOperationSuccess(
        message: 'Fee slab deleted successfully',
      ));

      add(const LoadFeeSlabs());
    } catch (e) {
      emit(FeeSlabError(message: e.toString()));
    }
  }

  Future<void> _onInitializeDefaultSlabs(
    InitializeDefaultSlabs event,
    Emitter<FeeSlabState> emit,
  ) async {
    try {
      emit(const FeeSlabLoading());

      await repository.initializeDefaultFeeSlabs();

      emit(const FeeSlabOperationSuccess(
        message: 'Default fee slabs initialized',
      ));

      add(const LoadFeeSlabs());
    } catch (e) {
      emit(FeeSlabError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _feeSlabsSubscription?.cancel();
    return super.close();
  }
}

// Internal event for stream updates
class _FeeSlabsUpdated extends FeeSlabEvent {
  final List<FeeSlabModel> feeSlabs;

  const _FeeSlabsUpdated(this.feeSlabs);

  @override
  List<Object?> get props => [feeSlabs];
}