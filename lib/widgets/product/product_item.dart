import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final loadedProduct;

  ProductItem(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.grey,
        height: 100,
        child: Text(
          loadedProduct.name,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
