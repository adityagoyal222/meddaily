import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/auth_user.dart';
import 'package:meddaily/provider/cart.dart';

class UserDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<AuthUser>> streamUsers() {
    var ref = _db.collection('users');

    return ref.snapshots().map(
        (list) => list.docs.map((doc) => AuthUser.fromFirestore(doc)).toList());
  }

  dynamic getUserByID(String id) async {
    final users = streamUsers();
    final user = await users.first;
    for (int i = 0; i < user.length; i++) {
      if (user[i].uid == id) {
        return user[i];
      }
    }
    return {};
  }

  Future<void> addUser(Map data) {
    var ref = _db.collection('users');
    return ref.doc(data['id']).set(Map<String, dynamic>.from(data));
  }

  Future<void> update(Map data, String id) {
    var ref = _db.collection('users');
    return ref.doc(id).update(data as Map<String, Object>);
  }

  Future<void> removeUser(Map data, String id) {
    var ref = _db.collection('users');
    return ref.doc(id).delete();
  }
}
