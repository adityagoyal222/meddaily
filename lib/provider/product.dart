import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String genericName;
  final String description;
  final String pharmaCompany;
  final String doze;
  final double price;
  final double discount;
  final bool prescriptionRequired;
  // final Category? category;
  final String imageUrl;
  final List<String> contraindications;
  final List<String> uses;
  final Map<String, String> medicineComposition;

  Product({
    required this.id,
    required this.name,
    required this.genericName,
    required this.description,
    required this.pharmaCompany,
    required this.doze,
    required this.price,
    required this.discount,
    required this.prescriptionRequired,
    // this.category,
    required this.imageUrl,
    required this.contraindications,
    required this.uses,
    required this.medicineComposition,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;
    print(doc.id);
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      genericName: data['genericName'] ?? '',
      description: data['description'] ?? '',
      pharmaCompany: data['pharmaCompany'] ?? '',
      doze: data['doze'] ?? '',
      price: data['price'].toDouble() ?? 0.0,
      discount: data['discount'].toDouble() ?? 0.0,
      prescriptionRequired: data['prescriptionRequired'] ?? false,
      // category: data['category'] as Category,
      imageUrl: data['imageUrl'] ?? '',
      contraindications: List<String>.from(data['contraindications']),
      uses: List<String>.from(data['uses']),
      medicineComposition:
          Map<String, String>.from(data['medicineComposition']),
    );
  }
}
