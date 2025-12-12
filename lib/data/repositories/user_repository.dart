// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:idoc_admin_side/data/models/user_model.dart';

// class UserRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Get all users
//   Stream<List<UserModel>> getAllUsers() {
//     return _firestore
//         .collection('users')
//         .snapshots()
//         .map((snapshot) {
//       final users = snapshot.docs
//           .map((doc) => UserModel.fromFirestore(doc.data(), doc.id))
//           .toList();
//       // Sort by createdAt in descending order (newest first)
//       users.sort((a, b) {
//         if (a.createdAt == null && b.createdAt == null) return 0;
//         if (a.createdAt == null) return 1;
//         if (b.createdAt == null) return -1;
//         return b.createdAt!.compareTo(a.createdAt!);
//       });
//       return users;
//     });
//   }

//   // Get user by ID
//   Future<UserModel?> getUserById(String userId) async {
//     try {
//       final doc = await _firestore.collection('users').doc(userId).get();
//       if (doc.exists) {
//         return UserModel.fromFirestore(doc.data()!, doc.id);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to get user: $e');
//     }
//   }

//   // Get total users count
//   Future<int> getTotalUsersCount() async {
//     final snapshot = await _firestore.collection('users').get();
//     return snapshot.docs.length;
//   }
// }

