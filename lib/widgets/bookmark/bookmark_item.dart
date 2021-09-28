import 'package:flutter/material.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class BookmarkItem extends StatelessWidget {
  final String productId;
  BookmarkItem(this.productId);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final currentProduct = products.where((i) => i.id == productId).toList()[0];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailScreen.routeName,
          arguments: productId,
        );
      },
      child: Card(
        color: Color(0xFFDFE8ED),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image(
                  image: AssetImage(currentProduct.imageUrl),
                ),
              ),
              Container(width: MediaQuery.of(context).size.width * 0.025),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        currentProduct.name,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      currentProduct.doze,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${currentProduct.price}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
