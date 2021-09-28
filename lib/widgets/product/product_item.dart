import 'package:flutter/material.dart';
import 'package:meddaily/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final loadedProduct;

  ProductItem(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: this.loadedProduct.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          border: Border.all(
            color: Colors.grey,
            // width: 2.0
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2
                // offset: Offset(6, 3), // changes position of shadow
                ),
          ],
        ),
        // color: Colors.grey,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    padding: EdgeInsets.all(9),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Image.asset(
                      loadedProduct.imageUrl,
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 16),
                    child: RichText(
                      text: TextSpan(
                        text: loadedProduct.name,
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 16),
                    child: RichText(
                      text: TextSpan(
                        text: "Rs. ${loadedProduct.price}",
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      ),
                    )),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
