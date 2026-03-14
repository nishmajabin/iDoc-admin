import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addCategory(Department category) async {
    await _firestore
        .collection('categories')
        .doc(category.name)
        .set(category.toMap());
  }

  Future<void> updateCategory(String docId, String name, String imageUrl) async {
    await _firestore.collection('categories').doc(docId).update({
      'name': name,
      'image': imageUrl,
    });
  }

  Future<void> deleteCategory(String docId) async {
    await _firestore.collection('categories').doc(docId).delete();
  }

  Future<List<Department>> loadCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    
    return snapshot.docs
        .map((doc) => Department.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  String generateCategoryId() {
    return _firestore.collection('categories').doc().id;
  }
}