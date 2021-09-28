import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meddaily/db/product_db.dart';

class Cart {
  final String id;
  final List<Item> items;
  double total;

  Cart({
    required this.id,
    required this.items,
    required this.total,
  });

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;
    print("cart_data ${doc.id}");
    return Cart(
      id: doc.id,
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
      total: data['total'] != null ? data['total'].toDouble() : 0.0,
    );
  }
}

class Item {
  String productID;
  int quantity;
  double price;
  double total;

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
