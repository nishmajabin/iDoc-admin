import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/application_model.dart';

class ApplicationRepository {
  final FirebaseFirestore _firestore;

  ApplicationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Stream of doctor applications (pending only)
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

  // Get all applications (including approved) - optional
  Stream<List<DoctorApplicationModel>> getAllDoctorApplicationsStream() {
    return _firestore.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DoctorApplicationModel.fromDocument(doc))
          .toList();
    });
  }

  // Delete/Reject doctor application
  Future<void> deleteApplication(String docId) async {
    try {
      await _firestore.collection('doctors').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting application: $e');
    }
  }

  // Approve doctor - just update status in the same document
  Future<void> approveDoctor(String docId) async {
    try {
      await _firestore.collection('doctors').doc(docId).update({
        'status': 'approved',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error approving doctor: $e');
    }
  }
}