// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:idoc_admin_side/data/models/doctor_model.dart';

// class DoctorRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Get all doctors
//   Stream<List<DoctorModel>> getAllDoctors() {
//     return _firestore
//         .collection('doctors')
//         .snapshots()
//         .map((snapshot) {
//       final doctors = snapshot.docs
//           .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
//           .toList();
//       // Sort by createdAt in descending order (newest first)
//       doctors.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null) return 0;
//         if (a.createdAt == null) return 1;
//         if (b.createdAt == null) return -1;
//         return b.createdAt!.compareTo(a.createdAt!);
//       });
//       return doctors;
//     });
//   }

//   // Get pending doctors (waiting for approval)
//   Stream<List<DoctorModel>> getPendingDoctors() {
//     return _firestore
//         .collection('doctors')
//         .where('approvalStatus', isEqualTo: 'pending')
//         .snapshots()
//         .map((snapshot) {
//       final doctors = snapshot.docs
//           .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
//           .toList();
//       // Sort by createdAt in descending order (newest first)
//       doctors.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null) return 0;
//         if (a.createdAt == null) return 1;
//         if (b.createdAt == null) return -1;
//         return b.createdAt!.compareTo(a.createdAt!);
//       });
//       return doctors;
//     });
//   }

//   // Get approved doctors
//   Stream<List<DoctorModel>> getApprovedDoctors() {
//     return _firestore
//         .collection('doctors')
//         .where('approvalStatus', isEqualTo: 'approved')
//         .snapshots()
//         .map((snapshot) {
//       final doctors = snapshot.docs
//           .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
//           .toList();
//       // Sort by createdAt in descending order (newest first)
//       doctors.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null) return 0;
//         if (a.createdAt == null) return 1;
//         if (b.createdAt == null) return -1;
//         return b.createdAt!.compareTo(a.createdAt!);
//       });
//       return doctors;
//     });
//   }

//   // Get rejected doctors
//   Stream<List<DoctorModel>> getRejectedDoctors() {
//     return _firestore
//         .collection('doctors')
//         .where('approvalStatus', isEqualTo: 'rejected')
//         .snapshots()
//         .map((snapshot) {
//       final doctors = snapshot.docs
//           .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
//           .toList();
//       // Sort by createdAt in descending order (newest first)
//       doctors.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null) return 0;
//         if (a.createdAt == null) return 1;
//         if (b.createdAt == null) return -1;
//         return b.createdAt!.compareTo(a.createdAt!);
//       });
//       return doctors;
//     });
//   }

//   // Get pending doctors count
//   Future<int> getPendingDoctorsCount() async {
//     final snapshot = await _firestore
//         .collection('doctors')
//         .where('approvalStatus', isEqualTo: 'pending')
//         .get();
//     return snapshot.docs.length;
//   }

//   // Approve doctor
//   Future<void> approveDoctor(String doctorId) async {
//     try {
//       await _firestore.collection('doctors').doc(doctorId).update({
//         'approvalStatus': 'approved',
//         'approvedAt': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       throw Exception('Failed to approve doctor: $e');
//     }
//   }

//   // Reject doctor
//   Future<void> rejectDoctor(String doctorId, {String? reason}) async {
//     try {
//       await _firestore.collection('doctors').doc(doctorId).update({
//         'approvalStatus': 'rejected',
//         'rejectedReason': reason ?? 'Application rejected by admin',
//       });
//     } catch (e) {
//       throw Exception('Failed to reject doctor: $e');
//     }
//   }

//   // Get doctor by ID
//   Future<DoctorModel?> getDoctorById(String doctorId) async {
//     try {
//       final doc = await _firestore.collection('doctors').doc(doctorId).get();
//       if (doc.exists) {
//         return DoctorModel.fromFirestore(doc.data()!, doc.id);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to get doctor: $e');
//     }
//   }
// }

