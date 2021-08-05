import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { Customer, User, Doctor }

class AuthUser {
  final String uid;
  final String email;
  final String name;
  final String? contact;
  Address? address;
  UserType userType;

  AuthUser({
    required this.uid,
    required this.email,
    required this.name,
    this.contact,
    this.address,
    this.userType = UserType.Customer,
  });

  factory AuthUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;

    return AuthUser(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      address: data['address'] != null
          ? data['address'].map(
              (address) => Address(
                district: data['address']['district'],
                city: data['address']['city'],
                locality: data['address']['locality'],
              ),
            )
          : null,
      userType: data['userType'] ?? UserType.Customer,
      contact: data['contact'] ?? null,
    );
  }
}

class Address {
  final String district;
  final String city;
  final String locality;

  Address({
    required this.district,
    required this.city,
    required this.locality,
  });
}
