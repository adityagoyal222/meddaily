import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/cart_db.dart';
import 'package:meddaily/db/order_db.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/order.dart';
import 'package:meddaily/widgets/cart/cart_item.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatelessWidget {
  static const routeName = '/cart-list';

  void orderNow(items, total, customerID, currentUser, BuildContext ctx) {
    final order_db = OrderDatabaseService();
    final cart_db = CartDatabaseService();
    final orders = Provider.of<List<Order>>(ctx, listen: false);
    final currentDate = DateTime.now();
    final orderedDate =
        new DateTime(currentDate.year, currentDate.month, currentDate.day);
    final itemsList = [];
    for (int i = 0; i < items.length; i++) {
      itemsList.add({
        "productID": items[i].productID,
        "quantity": items[i].quantity,
        "price": items[i].price,
        "total": items[i].total,
      });
    }
    order_db.addOrder(
      {
        "customerID": customerID,
        "approved": false,
        "paymentStatus": "Unpaid",
        "orderStatus": "Unapproved",
        "total": total,
        "items": itemsList,
        "orderedDate": orderedDate,
        "deliveredDate": null,
        "prescriptionImage": null
      },
      currentUser,
    );
    cart_db.clearCart(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<List<Cart>>(context);
    Cart cart = Cart(id: '', items: [], total: 0.0);
    if (carts.isNotEmpty) {
      cart = carts.last;
    }
    final currentUser = FirebaseAuth.instance.currentUser;
    // final cart = cart_db.getCartByID(FirebaseAuth.instance.currentUser!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: cart.items.length > 0
          ? Column(
              children: [
                if (carts.isNotEmpty)
                  if (cart.items.length > 0)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            CartItem(item: cart.items[index]),
                        itemCount: cart.items.length,
                      ),
                    ),
                if (cart.items.length > 0)
                  RaisedButton(
                    onPressed: () => orderNow(
                        cart.items, cart.total, cart.id, currentUser, context),
                    child: Text('Order Now'),
                    // onPressed: () => bottomModal(),
                  )
              ],
            )
          : Text(
              'No Items in the cart',
              style: TextStyle(color: Colors.black),
            ),
    );
  }
}
