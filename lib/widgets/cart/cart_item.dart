import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/cart_db.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/product.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final item;
  CartItem({this.item});
  @override
  _CartItemState createState() => _CartItemState();
}

Future<void> addQuantity(product, BuildContext ctx) async {
  final cart_db = CartDatabaseService();
  final carts = Provider.of<List<Cart>>(ctx, listen: false);
  Cart cart = Cart(id: '', items: [], total: 0.0);
  if (carts.isNotEmpty) {
    cart = carts.last;
  }
  var items = cart.items;
  final new_items = items.map((e) {
    if (e.productID == product.id) {
      e.quantity += 1;
      e.total += e.price;
      cart.total += e.price;
    }
    return {
      "price": e.price,
      "productID": e.productID,
      "quantity": e.quantity,
      "total": e.total
    };
  }).toList();
  cart_db.updateCart({"items": new_items, "total": cart.total},
      FirebaseAuth.instance.currentUser!);
}

Future<void> removeQuantity(product, ctx) async {
  final cart_db = CartDatabaseService();
  final carts = Provider.of<List<Cart>>(ctx, listen: false);
  Cart cart = Cart(id: '', items: [], total: 0.0);
  if (carts.isNotEmpty) {
    cart = carts.last;
  }
  var items = cart.items;
  bool deleteItem = false;
  double removePrice = 0;
  final new_items = items.map((e) {
    if (e.productID == product.id) {
      if (e.quantity == 1) {
        deleteItem = true;
        removePrice = e.price;
      } else {
        e.quantity -= 1;
        e.total -= e.price;
        cart.total -= e.price;
      }
    }
    return {
      "price": e.price,
      "productID": e.productID,
      "quantity": e.quantity,
      "total": e.total
    };
  }).toList();
  if (deleteItem == true) {
    cart.total -= removePrice;
    new_items.removeWhere((element) => element['productID'] == product.id);
  }
  cart_db.updateCart({"items": new_items, "total": cart.total},
      FirebaseAuth.instance.currentUser!);
}

Future<void> removeProduct(product, ctx) async {
  final cart_db = CartDatabaseService();
  final carts = Provider.of<List<Cart>>(ctx, listen: false);
  Cart cart = Cart(id: '', items: [], total: 0.0);
  if (carts.isNotEmpty) {
    cart = carts.last;
  }
  var items = cart.items;
  double removeTotal = 0;
  var new_items =
      items.where((element) => element.productID == product.id).toList();
  removeTotal = new_items[0].total;
  cart.total -= removeTotal;
  new_items.removeWhere((element) => element.productID == product.id);
  cart_db.updateCart({"items": new_items, "total": cart.total},
      FirebaseAuth.instance.currentUser!);
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final products = Provider.of<List<Product>>(context);
    Product product = Product(
      id: '',
      name: '',
      genericName: '',
      description: '',
      pharmaCompany: '',
      doze: '',
      price: 0.0,
      discount: 0.0,
      prescriptionRequired: false,
      imageUrl: '',
      contraindications: [],
      uses: [],
      medicineComposition: {},
    );
    if (products.isNotEmpty) {
      product = products
          .where((element) => element.id == item.productID)
          .toList()
          .last;
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Product Name: ${product.name}",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Price: Rs. ${item.quantity * product.price}",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity:",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => removeQuantity(product, context),
                      icon: Icon(Icons.remove_outlined),
                      color: Color(0xFF7DEA82),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () => addQuantity(product, context),
                      icon: Icon(Icons.add),
                      color: Color(0xFF7DEA82),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton.icon(
                  onPressed: () => removeProduct(product, context),
                  icon: Icon(Icons.highlight_off_outlined),
                  label: Text('Delete'),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
