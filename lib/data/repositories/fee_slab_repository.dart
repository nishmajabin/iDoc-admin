import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/fee_slab_model.dart';

class FeeSlabRepository {
  final FirebaseFirestore _firestore;

  FeeSlabRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Stream of all fee slabs
  Stream<List<FeeSlabModel>> getFeeSlabsStream() {
    return _firestore
        .collection('feeSlabs')
        .orderBy('minExperience')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FeeSlabModel.fromDocument(doc))
          .toList();
    });
  }

  /// Get all fee slabs (one-time fetch)
  Future<List<FeeSlabModel>> getFeeSlabs() async {
    try {
      final snapshot = await _firestore
          .collection('feeSlabs')
          .orderBy('minExperience')
          .get();

      return snapshot.docs
          .map((doc) => FeeSlabModel.fromDocument(doc))
          .toList();
    } catch (e) {
      log('Error fetching fee slabs: $e');
      return [];
    }
  }

  /// Create new fee slab
  Future<void> createFeeSlab(FeeSlabModel feeSlab) async {
    try {
      // Validate no overlapping ranges
      final overlaps = await _checkOverlappingRanges(
        feeSlab.minExperience,
        feeSlab.maxExperience,
      );

      if (overlaps) {
        throw Exception('Fee slab range overlaps with existing slab');
      }

      await _firestore.collection('feeSlabs').add(feeSlab.toMap());
    } catch (e) {
      log('Error creating fee slab: $e');
      rethrow;
    }
  }

  /// Update existing fee slab
  Future<void> updateFeeSlab(FeeSlabModel feeSlab) async {
    try {
      if (feeSlab.id == null) {
        throw Exception('Fee slab ID is required for update');
      }

      // Validate no overlapping ranges (excluding current slab)
      final overlaps = await _checkOverlappingRanges(
        feeSlab.minExperience,
        feeSlab.maxExperience,
        excludeId: feeSlab.id,
      );

      if (overlaps) {
        throw Exception('Fee slab range overlaps with existing slab');
      }

      await _firestore.collection('feeSlabs').doc(feeSlab.id).update({
        'minExperience': feeSlab.minExperience,
        'maxExperience': feeSlab.maxExperience,
        'consultationFee': feeSlab.consultationFee,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log('Error updating fee slab: $e');
      rethrow;
    }
  }

  /// Delete fee slab
  Future<void> deleteFeeSlab(String slabId) async {
    try {
      await _firestore.collection('feeSlabs').doc(slabId).delete();
    } catch (e) {
      log('Error deleting fee slab: $e');
      rethrow;
    }
  }

  /// Calculate consultation fee based on experience
  Future<double> calculateConsultationFee(int experience) async {
    try {
      final slabs = await getFeeSlabs();

      // Find matching slab
      for (var slab in slabs) {
        if (experience >= slab.minExperience &&
            experience <= slab.maxExperience) {
          return slab.consultationFee;
        }
      }

      // Default fee if no slab matches
      return 300.0;
    } catch (e) {
      log('Error calculating consultation fee: $e');
      return 300.0; // Default fallback
    }
  }

  /// Check for overlapping experience ranges
  Future<bool> _checkOverlappingRanges(
    int minExp,
    int maxExp, {
    String? excludeId,
  }) async {
    try {
      final snapshot = await _firestore.collection('feeSlabs').get();

      for (var doc in snapshot.docs) {
        if (excludeId != null && doc.id == excludeId) continue;

        final data = doc.data();
        final existingMin = data['minExperience'] as int;
        final existingMax = data['maxExperience'] as int;

        // Check for overlap
        if ((minExp >= existingMin && minExp <= existingMax) ||
            (maxExp >= existingMin && maxExp <= existingMax) ||
            (minExp <= existingMin && maxExp >= existingMax)) {
          return true;
        }
      }

      return false;
    } catch (e) {
      log('Error checking overlapping ranges: $e');
      return false;
    }
  }

  /// Initialize default fee slabs (call once during setup)
  Future<void> initializeDefaultFeeSlabs() async {
    try {
      final existing = await getFeeSlabs();
      if (existing.isNotEmpty) return; // Already initialized

      final defaultSlabs = [
        FeeSlabModel(
          minExperience: 1,
          maxExperience: 2,
          consultationFee: 200.0,
        ),
        FeeSlabModel(
          minExperience: 3,
          maxExperience: 5,
          consultationFee: 350.0,
        ),
        FeeSlabModel(
          minExperience: 6,
          maxExperience: 10,
          consultationFee: 500.0,
        ),
        FeeSlabModel(
          minExperience: 11,
          maxExperience: 999, // 999 represents "unlimited"
          consultationFee: 700.0,
        ),
      ];

      for (var slab in defaultSlabs) {
        await _firestore.collection('feeSlabs').add(slab.toMap());
      }

      log('Default fee slabs initialized successfully');
    } catch (e) {
      log('Error initializing default fee slabs: $e');
    }
  }
}