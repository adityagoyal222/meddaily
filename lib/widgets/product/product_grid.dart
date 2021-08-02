import 'package:flutter/material.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/widgets/product/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loadedProducts = Provider.of<List<Product>>(context);
    return Container(
      height: 550,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _loadedProducts.length,
        itemBuilder: (ctx, i) => (ProductItem(_loadedProducts[i])),
      ),
    );
  }
}
