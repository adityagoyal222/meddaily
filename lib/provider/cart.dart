import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meddaily/db/product_db.dart';

class Cart {
  final String id;
  final String customerID;
  final List<Item> items;
  final double total;

  Cart({
    required this.id,
    required this.customerID,
    required this.items,
    required this.total,
  });

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;
    return Cart(
      id: doc.id,
      customerID: data['customerID'] ?? '',
      items: data['items']
          .map(
            (item) => Item(
              productID: item['productID'],
              quantity: item['quantity'],
              price: item['price'].toDouble(),
              total: item['total'].toDouble(),
            ),
          )
          .toList(),
      total: data['total'].toDouble(),
    );
  }
}

class Item {
  final String productID;
  final int quantity;
  final double price;
  final double total;

  Item({
    required this.productID,
    required this.quantity,
    required this.price,
    required this.total,
  });

  // double calculateTotal() {
  //   final _prod_db = ProductDatabaseService();
  //   final _product = _prod_db.getProductByID(this.productID);
  //   this.total = _product.id * quantity;
  //   return this.total!;
  // }
}
