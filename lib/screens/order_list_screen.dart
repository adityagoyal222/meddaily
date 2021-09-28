import 'package:flutter/material.dart';
import 'package:meddaily/provider/order.dart';
import 'package:meddaily/screens/cart_list_screen.dart';
import 'package:meddaily/screens/sidebar.dart';
import 'package:meddaily/widgets/order/order_block.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatelessWidget {
  static const routeName = '/order-list';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBF3F9),
        elevation: 0,
        leading: BackButton(
          color: Color(0xFF273238),
        ),
        title: Center(
          child: Text(
            'Orders',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF273238),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              iconSize: 24,
              color: Color(0xFF273238),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => CartListScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => OrderBlock(orders[index]),
              itemCount: orders.length,
            ),
          ),
        ],
      ),
    );
  }
}
