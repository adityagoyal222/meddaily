import 'package:flutter/material.dart';
import 'package:meddaily/provider/bookmark.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/screens/cart_list_screen.dart';
import 'package:meddaily/screens/sidebar.dart';
import 'package:meddaily/widgets/bookmark/bookmark_item.dart';
import 'package:meddaily/widgets/product/product_item.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  static const routename = '/bookmarks';

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final bookmarks = Provider.of<List<Bookmark>>(context);
    Bookmark bookmark = Bookmark(id: "", products: []);
    if (bookmarks.isNotEmpty) {
      bookmark = bookmarks.last;
    }
    final products = Provider.of<List<Product>>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFEBF3F9),
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBF3F9),
        elevation: 0,
        leading: BackButton(
          color: Color(0xFF273238),
        ),
        title: Center(
          child: Text(
            'Bookmarks',
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
      // body: bookmark.products.length > 0
      //     ? Column(
      //         children: [
      //           if (products.isNotEmpty)
      //             Expanded(
      //               child: ListView.builder(
      //                 itemCount: bookmark.products.length,
      //                 itemBuilder: (context, index) {
      //                   final loadedProduct = products.firstWhere(
      //                     (element) => element.id == bookmark.products[index],
      //                     orElse: () => Product(
      //                       contraindications: [],
      //                       description: '',
      //                       discount: 0.0,
      //                       doze: '',
      //                       genericName: '',
      //                       id: '',
      //                       imageUrl: '',
      //                       medicineComposition: {},
      //                       name: '',
      //                       pharmaCompany: '',
      //                       prescriptionRequired: false,
      //                       price: 0.0,
      //                       uses: [],
      //                     ),
      //                   );
      //                   return ProductItem(loadedProduct);
      //                 },
      //               ),
      //             ),
      //         ],
      //       )
      //     : Text(
      //         'No Bookmarked Products',
      //         style: TextStyle(color: Colors.black),
      //       ),
      body: bookmark.products.length > 0
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    BookmarkItem(bookmark.products[index]),
                padding: EdgeInsets.only(left: 5, right: 5),
                itemCount: bookmark.products.length,
              ),
            )
          : Text(
              'No Bookmarked Products',
              style: TextStyle(color: Colors.black),
            ),
    );
  }
}
