import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meddaily/provider/auth_user.dart';
import 'package:meddaily/provider/cart.dart';

class AuthUserDatabaseService {
  final String uid;
  AuthUserDatabaseService(this.uid);
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<AuthUser> get userData {
    var ref = _db.collection('users').doc(uid);

    return ref.snapshots().map((snapshot) => AuthUser.fromFirestore(snapshot));
  }
}
