import 'package:equatable/equatable.dart';

class FeeSlabDialogState extends Equatable {
  final bool isUnlimited;

  const FeeSlabDialogState({
    this.isUnlimited = false,
  });

  FeeSlabDialogState copyWith({
    bool? isUnlimited,
  }) {
    return FeeSlabDialogState(
      isUnlimited: isUnlimited ?? this.isUnlimited,
    );
  }

  @override
  List<Object?> get props => [isUnlimited];
}