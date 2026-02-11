import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';
import 'package:idoc_admin_side/data/repositories/fee_slab_repository.dart';

class ApplicationRepository {
  final FirebaseFirestore _firestore;
  final FeeSlabRepository _feeSlabRepository;

  ApplicationRepository({
    FirebaseFirestore? firestore,
    FeeSlabRepository? feeSlabRepository,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _feeSlabRepository = feeSlabRepository ?? FeeSlabRepository();

  Stream<List<DoctorApplicationModel>> getDoctorApplicationsStream() {
    return _firestore
        .collection('doctors')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorApplicationModel.fromDocument(doc))
          .toList();
    });
  }

  Stream<List<DoctorApplicationModel>> getAllDoctorApplicationsStream() {
    return _firestore.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorApplicationModel.fromDocument(doc))
          .toList();
    });
  }

  Future<void> deleteApplication(String docId) async {
    try {
      await _firestore.collection('doctors').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting application: $e');
    }
  }

  /// Approve doctor with automatic fee calculation
  Future<void> approveDoctor(String docId) async {
    try {
      // Get doctor's current data
      final doctorDoc = await _firestore.collection('doctors').doc(docId).get();
      
      if (!doctorDoc.exists) {
        throw Exception('Doctor not found');
      }

      final doctorData = doctorDoc.data() as Map<String, dynamic>;
      final experience = doctorData['experience'] as int? ?? 0;

      // Calculate consultation fee based on experience
      final consultationFee =
          await _feeSlabRepository.calculateConsultationFee(experience);

      // Update doctor status and consultation fee
      await _firestore.collection('doctors').doc(docId).update({
        'status': 'approved',
        'consultationFee': consultationFee,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error approving doctor: $e');
    }
  }

  /// Block a doctor with optional reason
  Future<void> blockDoctor(String docId, {String? reason}) async {
    try {
      final doctorDoc = await _firestore.collection('doctors').doc(docId).get();
      
      if (!doctorDoc.exists) {
        throw Exception('Doctor not found');
      }

      await _firestore.collection('doctors').doc(docId).update({
        'blocked': true,
        'blockReason': reason,
        'blockedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error blocking doctor: $e');
    }
  }

  /// Unblock a doctor
  Future<void> unblockDoctor(String docId) async {
    try {
      final doctorDoc = await _firestore.collection('doctors').doc(docId).get();
      
      if (!doctorDoc.exists) {
        throw Exception('Doctor not found');
      }

      await _firestore.collection('doctors').doc(docId).update({
        'blocked': false,
        'blockReason': null,
        'blockedAt': null,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error unblocking doctor: $e');
    }
  }

  /// Recalculate fees for all approved doctors (useful after fee slab updates)
  Future<void> recalculateAllDoctorFees() async {
    try {
      final snapshot = await _firestore
          .collection('doctors')
          .where('status', isEqualTo: 'approved')
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final experience = data['experience'] as int? ?? 0;
        
        final consultationFee =
            await _feeSlabRepository.calculateConsultationFee(experience);

        await _firestore.collection('doctors').doc(doc.id).update({
          'consultationFee': consultationFee,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error recalculating doctor fees: $e');
    }
  }
}