import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meddaily/provider/cart.dart';

class Order {
  final String id;
  final String customerID;
  bool approved;
  String paymentStatus;
  String orderStatus;
  final double total;
  final List<Item> items;
  final Timestamp orderedDate;
  Timestamp? deliveredDate;
  String? prescriptionImage;

  Order({
    required this.id,
    required this.customerID,
    this.approved = false,
    this.paymentStatus = "Unpaid",
    this.orderStatus = "Unapproved",
    required this.total,
    required this.items,
    required this.orderedDate,
    this.deliveredDate,
    this.prescriptionImage,
  });

  factory Order.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;
    return Order(
      id: doc.id,
      customerID: data['customerID'],
      total: data['total'] != null ? data['total'].toDouble() : 0.0,
      orderedDate: data['orderedDate'],
      approved: data['approved'] != null ? data['approved'] : false,
      paymentStatus:
          data['paymentStatus'] != null ? data['paymentStatus'] : "Unpaid",
      orderStatus:
          data['orderStatus'] != null ? data['orderStatus'] : "Unapproved",
      deliveredDate: data['deliveredDate'] ?? null,
      prescriptionImage: data['prescriptionImage'] ?? null,
      items: data['items'] != null
          ? List<Item>.from(data['items']
              .map(
                (item) => Item(
                  productID: item['productID'],
                  quantity: item['quantity'],
                  price: item['price'].toDouble(),
                  total: item['total'].toDouble(),
                ),
              )
              .toList())
          : [],
    );
  }
}
