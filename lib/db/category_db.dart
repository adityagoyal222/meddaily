import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/category.dart';

class CategoryDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Category>> streamCategory() {
    var ref = _db.collection('categories');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Category.fromFirestore(doc)).toList());
  }

  dynamic getCategoryByID(String id) async {
    final categories = streamCategory();
    final category = await categories.first;
    for (int i = 0; i < category.length; i++) {
      if (category[i].id == id) {
        return category[i];
      }
    }
    return {};
  }

  Future<DocumentReference> addCategory(Map data) {
    var ref = _db.collection('categories');
    return ref.add(data as Map<String, dynamic>);
  }

  Future<void> updateCategory(Map data, String id) {
    var ref = _db.collection('categories');
    return ref.doc(id).update(data as Map<String, Object>);
  }

  Future<void> removeCategories(Map data, String id, User user) {
    var ref = _db.collection('categories');
    return ref.doc(id).delete();
  }
}
