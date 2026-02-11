import 'package:cloud_firestore/cloud_firestore.dart';

class FeeSlabModel {
  final String? id;
  final int minExperience;
  final int maxExperience;
  final double consultationFee;
  final DateTime createdAt;
  final DateTime? updatedAt;

  FeeSlabModel({
    this.id,
    required this.minExperience,
    required this.maxExperience,
    required this.consultationFee,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'minExperience': minExperience,
      'maxExperience': maxExperience,
      'consultationFee': consultationFee,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory FeeSlabModel.fromMap(Map<String, dynamic> map, String documentId) {
    return FeeSlabModel(
      id: documentId,
      minExperience: map['minExperience'] ?? 0,
      maxExperience: map['maxExperience'] ?? 0,
      consultationFee: (map['consultationFee'] ?? 0.0).toDouble(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  factory FeeSlabModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FeeSlabModel.fromMap(data, doc.id);
  }

  FeeSlabModel copyWith({
    String? id,
    int? minExperience,
    int? maxExperience,
    double? consultationFee,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeeSlabModel(
      id: id ?? this.id,
      minExperience: minExperience ?? this.minExperience,
      maxExperience: maxExperience ?? this.maxExperience,
      consultationFee: consultationFee ?? this.consultationFee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get experienceRange {
    if (maxExperience >= 100) {
      return '$minExperience+ years';
    }
    return '$minExperience-$maxExperience years';
  }

  @override
  String toString() {
    return 'FeeSlabModel(id: $id, range: $experienceRange, fee: ₹$consultationFee)';
  }
}