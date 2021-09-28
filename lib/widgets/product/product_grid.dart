import 'package:flutter/material.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/widgets/product/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loadedProducts = Provider.of<List<Product>>(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: 550,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (2 / 3),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _loadedProducts.length,
        itemBuilder: (ctx, i) => (ProductItem(_loadedProducts[i])),
      ),
    );
  }
}
