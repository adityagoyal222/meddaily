import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/product.dart';

class ProductDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> streamProducts() {
    var ref = _db.collection('products');
    return ref.snapshots().map(
          (snapShot) => snapShot.docs
              .map(
                (doc) => Product.fromFirestore(doc),
              )
              .toList(),
        );
  }

  dynamic getProductByID(String id) async {
    final products = streamProducts();
    final product = await products.first;
    for (int i = 0; i < product.length; i++) {
      if (product[i].id == id) {
        return product[i];
      }
    }
    return {};
  }

  Future<DocumentReference> addProduct(Map data) {
    var ref = _db.collection('products');
    return ref.add(data as Map<String, dynamic>);
  }

  Future<void> updateProduct(Map data, String id) {
    var ref = _db.collection('products');
    return ref.doc(id).update(data as Map<String, Object>);
  }

  Future<void> removeProduct(Map data, String id) {
    var ref = _db.collection('products');
    return ref.doc(id).delete();
  }
}
