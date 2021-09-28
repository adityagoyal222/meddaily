import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/order_db.dart';
import 'package:meddaily/provider/order.dart';

class OrderBlock extends StatelessWidget {
  final Order order;
  OrderBlock(this.order);

  void cancelOrder(orderID, currentUser) {
    final order_db = OrderDatabaseService();
    order_db.updateOrder({"orderStatus": "Cancelled"}, currentUser, orderID);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    // return Container(
    //   child: Row(
    //     children: [
    //       Text('${order.id}'),
    //       if (order.orderStatus != "Cancelled")
    //         FlatButton(
    //           onPressed: () {
    //             cancelOrder(order.id, currentUser);
    //           },
    //           child: Text('Cancel Order'),
    //           color: Colors.red,
    //         ),
    //       if (order.orderStatus == "Cancelled")
    //         Text(
    //           'Cancelled',
    //           style: TextStyle(
    //             fontStyle: FontStyle.italic,
    //           ),
    //         )
    //     ],
    //   ),
    // );
    final orderDate = order.orderedDate.toDate();
    return Column(
      children: [
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order No : ${order.id}'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Order Date : ${orderDate.year}-${orderDate.month}-${orderDate.day}'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Items : ${order.items.length}"),
                    Text("Total Cost : ${order.total}"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${order.orderStatus}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(width: 10),
                    if (order.orderStatus != "Cancelled")
                      FlatButton(
                        onPressed: () {
                          cancelOrder(order.id, currentUser);
                        },
                        child: Text('Cancel Order'),
                        color: Colors.red,
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
