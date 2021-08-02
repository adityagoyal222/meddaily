import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/cart.dart';

class CartDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Cart>> streamCarts(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('cart');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Cart.fromFirestore(doc)).toList());
  }

  dynamic getCartByID(String id, User user) async {
    final carts = streamCarts(user);
    final cart = await carts.first;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id) {
        return cart[i];
      }
    }
    return {};
  }

  Future<DocumentReference> addCart(Map data, User user) {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    return ref.add(data as Map<String, dynamic>);
  }

  Future<void> updateCart(Map data, String id, User user) {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    return ref.doc(id).update(data as Map<String, Object>);
  }

  Future<void> removeCart(Map data, String id, User user) {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    return ref.doc(id).delete();
  }
}
