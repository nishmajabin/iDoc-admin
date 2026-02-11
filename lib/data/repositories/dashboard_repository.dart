import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardRepository {
  final FirebaseFirestore _firestore;

  DashboardRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    try {
      QuerySnapshot snapshot;

      try {
        snapshot = await _firestore.collection('approveddoctors').get();
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        }
      } catch (e) {
        print('approveddoctors collection not found, trying doctors...');
      }

      snapshot = await _firestore.collection('doctors').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error fetching doctors: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPatients() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching patients: $e');
    }
  }

  Map<String, int> countByGender(List<Map<String, dynamic>> data) {
    int male = 0;
    int female = 0;

    for (var item in data) {
      final gender =
          (item['gender']?.toString() ?? item['genter']?.toString() ?? '')
              .toLowerCase();

      if (gender.contains('male') && !gender.contains('female')) {
        male++;
      } else if (gender.contains('female')) {
        female++;
      }
    }

    return {'male': male, 'female': female};
  }
}
