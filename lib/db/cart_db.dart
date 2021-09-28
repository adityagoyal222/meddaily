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

  Future<Cart> getCartByID(User user) async {
    final carts = streamCarts(user);
    final cart = await carts.first;
    print(cart);
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id.trim() == user.uid) {
        return cart[i];
      }
    }
    return Cart(id: '', items: [], total: 0);
  }

  Future<void> addCart(Map data, User user) async {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    final snapshot = await ref.get();
    if (snapshot.docs.length == 0) {
      ref.doc(user.uid).set({"items": [], "total": 0.0});
    }
    return ref.doc(user.uid).update(Map<String, dynamic>.from(data));
  }

  Future<void> updateCart(Map data, User user) async {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    final snapshot = await ref.get();
    if (snapshot.docs.length == 0) {
      ref.doc(user.uid).set({"items": [], "total": 0.0});
    }

    return ref.doc(user.uid).update(Map<String, dynamic>.from(data));
  }

  Future<void> clearCart(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('cart');
    return ref.doc(user.uid).update({"items": [], "total": 0.0});
  }
}
