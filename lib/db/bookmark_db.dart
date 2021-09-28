import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/bookmark.dart';

class BookmarkDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Bookmark>> streamBookmarks(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('bookmarks');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Bookmark.fromFirestore(doc)).toList());
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

  Future<void> addBookmark(Map data, User user) async {
    var ref = _db.collection('users').doc(user.uid).collection('bookmarks');
    final snapshot = await ref.get();
    if (snapshot.docs.length == 0) {
      ref.doc(user.uid).set({"products": []});
    }
    return ref.doc(user.uid).update(Map<String, dynamic>.from(data));
  }

  Future<void> updateBookmark(Map data, User user) async {
    var ref = _db.collection('users').doc(user.uid).collection('bookmarks');
    final snapshot = await ref.get();
    if (snapshot.docs.length == 0) {
      ref.doc(user.uid).set({"products": []});
    }

    return ref.doc(user.uid).update(Map<String, dynamic>.from(data));
  }

  Future<void> clearBookmarks(Map data, User user) {
    var ref = _db.collection('users').doc(user.uid).collection('bookmarks');
    return ref.doc(user.uid).update({"products": []});
  }
}
