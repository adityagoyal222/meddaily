import 'package:flutter/material.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/widgets/product/product_grid.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  static const routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          title: Text('First Aid'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Best Match",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    Text(
                      "<>",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ), // Will replace with icon
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "<>",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ), // Will replace with icon
                    Text(
                      "Filter",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                )
              ],
            ),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}
