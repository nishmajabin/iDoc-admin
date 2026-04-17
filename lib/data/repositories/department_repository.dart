// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:idoc_admin_side/data/models/department_model.dart';

// class CategoryRepository {
//   final FirebaseFirestore _firestore;

//   CategoryRepository({FirebaseFirestore? firestore})
//       : _firestore = firestore ?? FirebaseFirestore.instance;

//   Future<void> addCategory(Department category) async {
//     await _firestore
//         .collection('categories')
//         .doc(category.name)
//         .set(category.toMap());
//   }

//   Future<void> updateCategory(String docId, String name, String imageUrl) async {
//     await _firestore.collection('categories').doc(docId).update({
//       'name': name,
//       'image': imageUrl,
//     });
//   }

//   Future<void> deleteCategory(String docId) async {
//     await _firestore.collection('categories').doc(docId).delete();
//   }

//   Future<List<Department>> loadCategories() async {
//     final snapshot = await _firestore.collection('categories').get();
    
//     return snapshot.docs
//         .map((doc) => Department.fromFirestore(doc.data(), doc.id))
//         .toList();
//   }

//   String generateCategoryId() {
//     return _firestore.collection('categories').doc().id;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _collection =>
      _firestore.collection('categories');

  Future<void> addCategory(Department category) async {
    await _collection.doc(category.name).set(category.toMap());
  }

  Future<void> updateCategory(
      String docId, String name, String imageUrl) async {
    await _collection.doc(docId).update({'name': name, 'image': imageUrl});
  }

  Future<void> deleteCategory(String docId) async {
    await _collection.doc(docId).delete();
  }

  Future<List<Department>> loadCategories() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => Department.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  String generateCategoryId() => _collection.doc().id;

  /// Returns `true` if a category with [name] already exists.
  /// Comparison is case-insensitive to catch "Cardiology" vs "cardiology".
  Future<bool> categoryExists(String name) async {
    final snapshot = await _collection
        .where('name', isEqualTo: name.trim())
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) return true;

    // Secondary case-insensitive check against the full list
    // (Firestore text search is case-sensitive by default).
    final all = await loadCategories();
    return all.any(
      (c) => c.name.trim().toLowerCase() == name.trim().toLowerCase(),
    );
  }
}