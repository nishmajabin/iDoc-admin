import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Add a new category to Firestore
  Future<void> addCategory(Department category) async {
    await _firestore
        .collection('categories')
        .doc(category.name)
        .set(category.toMap());
  }

  /// Update an existing category
  Future<void> updateCategory(String docId, String name, String imageUrl) async {
    await _firestore.collection('categories').doc(docId).update({
      'name': name,
      'image': imageUrl,
    });
  }

  /// Delete a category
  Future<void> deleteCategory(String docId) async {
    await _firestore.collection('categories').doc(docId).delete();
  }

  /// Load all categories
  Future<List<Department>> loadCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    
    return snapshot.docs
        .map((doc) => Department.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  /// Generate a new category ID
  String generateCategoryId() {
    return _firestore.collection('categories').doc().id;
  }
}