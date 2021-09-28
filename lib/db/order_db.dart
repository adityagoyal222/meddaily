import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/order.dart';

class OrderDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Order>> streamOrders(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('orders');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Order.fromFireStore(doc)).toList());
  }

  // Future<Cart> getCartByID(User user) async {
  //   final carts = streamCarts(user);
  //   final cart = await carts.first;
  //   print(cart);
  //   for (int i = 0; i < cart.length; i++) {
  //     if (cart[i].id.trim() == user.uid) {
  //       return cart[i];
  //     }
  //   }
  //   return Cart(id: '', items: [], total: 0);
  // }

  Future<DocumentReference> addOrder(Map data, User user) async {
    var ref = _db.collection('users').doc(user.uid).collection('orders');
    final snapshot = await ref.get();
    // if (snapshot.docs.length == 0) {
    //   ref.doc(user.uid).set({"items": [], "total": 0.0});
    // }
    // return ref.doc(user.uid).update(Map<String, dynamic>.from(data));
    return ref.add(Map<String, dynamic>.from(data));
  }

  Future<void> updateOrder(Map data, User user, String id) async {
    var ref = _db.collection('users').doc(user.uid).collection('orders');
    final snapshot = await ref.get();
    return ref.doc(id).update(Map<String, dynamic>.from(data));
  }

  Future<void> removeOrder(Map data, User user, String id) {
    var ref = _db.collection('users').doc(user.uid).collection('orders');
    return ref.doc(id).delete();
  }
}
