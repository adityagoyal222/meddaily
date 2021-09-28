import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/bookmark_db.dart';
import 'package:meddaily/db/cart_db.dart';
import 'package:meddaily/provider/bookmark.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/screens/sidebar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<void> addToCart(Product product, BuildContext ctx) async {
    final carts = Provider.of<List<Cart>>(ctx, listen: false);
    Cart cart = Cart(id: "", items: [], total: 0.0);
    if (carts.isNotEmpty) {
      cart = carts.last;
    }

    bool exists = false;
    for (int i = 0; i < cart.items.length; i++) {
      if (cart.items[i].productID == product.id) {
        exists = true;
      }
    }
    if (exists == false) {
      addProductToCart(product, ctx);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Product added to cart."),
          backgroundColor: Colors.black,
        ),
      );
    } else {
      updateQuantity(product, ctx);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Quantity updated in cart."),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  Future<void> addProductToCart(product, BuildContext ctx) async {
    final data = [
      {
        "productID": product.id,
        "price": product.price,
        "quantity": 1,
        "total": product.price
      }
    ];
    final cart_db = CartDatabaseService();
    final carts = Provider.of<List<Cart>>(ctx, listen: false);
    if (carts.isNotEmpty) {
      final cart = carts.last;
      final total = cart.total += product.price;
      cart_db.addCart({"items": FieldValue.arrayUnion(data), "total": total},
          FirebaseAuth.instance.currentUser!);
    }
  }

  Future<void> updateQuantity(product, BuildContext ctx) async {
    final cart_db = CartDatabaseService();
    final carts = Provider.of<List<Cart>>(ctx, listen: false);
    final cart = carts.last;
    var items = cart.items;
    final new_items = items.map((e) {
      if (e.productID == product.id) {
        e.quantity += 1;
        e.total += e.price;
        cart.total += e.price;
      }
      return {
        "price": e.price,
        "productID": e.productID,
        "quantity": e.quantity,
        "total": e.total
      };
    }).toList();
    cart_db.updateCart({"items": new_items, "total": cart.total},
        FirebaseAuth.instance.currentUser!);
  }

  void addToBookmark(id, user, BuildContext ctx) {
    final bookmark_db = BookmarkDatabaseService();
    final bookmarks = Provider.of<List<Bookmark>>(ctx, listen: false);
    if (bookmarks.isNotEmpty) {
      final bookmark = bookmarks.last;
      bookmark.products.add(id);
      bookmark_db.addBookmark({"products": bookmark.products}, user);
    }
  }

  void removeFromBookmark(id, user, BuildContext ctx) {
    final bookmark_db = BookmarkDatabaseService();
    final bookmarks = Provider.of<List<Bookmark>>(ctx, listen: false);
    final bookmark;
    if (bookmarks.isNotEmpty) {
      bookmark = bookmarks.first;
      bookmark.products.remove(id);
      bookmark_db.updateBookmark({"products": bookmark.products}, user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final products = Provider.of<List<Product>>(context);
    final currentProduct = products.where((i) => i.id == id).toList()[0];
    final currentUser = FirebaseAuth.instance.currentUser;
    final bookmarks = Provider.of<List<Bookmark>>(context);
    int bookmarkExists = -1;
    final bookmark = Bookmark(id: '', products: []);
    if (bookmarks.isNotEmpty) {
      final bookmark = bookmarks.first;
      bookmarkExists = bookmark.products
          .indexWhere((element) => element == currentProduct.id);
    }
    print(bookmarkExists);

    return Scaffold(
      backgroundColor: Color(0xFFEBF3F9),
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBF3F9),
        elevation: 0,
        leading: BackButton(
          color: Color(0xFF273238),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.favorite_border),
        //     iconSize: 24,
        //     color: Color(0xFF273238),
        //   )
        // ],
      ),
      // body: Column(
      //   children: [
      //     Row(
      //       children: [
      //         Text(currentProduct.name),
      //         if (bookmarkExists == -1)
      //           FlatButton(
      //             onPressed: () {
      //               addToBookmark(currentProduct.id, currentUser, context);
      //               setState(() {
      //                 bookmarkExists = bookmark.products.indexWhere(
      //                     (element) => element == currentProduct.id);
      //               });
      //             },
      //             child: Text('Add to Bookmark'),
      //           ),
      //         if (bookmarkExists == 1)
      //           FlatButton(
      //             onPressed: () {
      //               removeFromBookmark(currentProduct.id, currentUser, context);
      //               setState(() {
      //                 bookmarkExists = bookmark.products.indexWhere(
      //                     (element) => element == currentProduct.id);
      //               });
      //             },
      //             child: Text('Remove From Bookmark'),
      //           )
      //       ],
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         addToCart(currentProduct, context);
      //       },
      //       child: Icon(Icons.add),
      //     ),
      //   ],
      // ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image(
                image: AssetImage(currentProduct.imageUrl),
                height: 220,
                width: 220,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 50,
                  width: 50,
                  child: Image(
                    image: AssetImage('assets/images/filler_img.png'),
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFF273238),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Card(
                        //   color: Color(0xFF273238),
                        //   shape: RoundedRectangleBorder(
                        //     side: BorderSide(
                        //       color: Colors.red,
                        //       width: 3,
                        //     ),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   elevation: 0,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //       top: 5,
                        //       bottom: 5,
                        //       left: 10,
                        //       right: 10,
                        //     ),
                        //     child: Text(
                        //       "Out of Stock",
                        //       style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         color: Color(0xFFEBF3F9),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Card(
                          color: Color(0xFF273238),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.green,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              "Over the Counter",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFEBF3F9),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      currentProduct.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEBF3F9),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentProduct.description,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFFEBF3F9),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (bookmarkExists == -1)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF7DEA82),
                            ),
                            child: IconButton(
                              onPressed: () {
                                addToBookmark(
                                    currentProduct.id, currentUser, context);
                                setState(() {
                                  bookmarkExists = bookmark.products.indexWhere(
                                      (element) =>
                                          element == currentProduct.id);
                                });
                              },
                              icon: Icon(
                                Icons.bookmark_add_outlined,
                              ),
                            ),
                          ),
                        if (bookmarkExists >= 0)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF7DEA82),
                            ),
                            child: IconButton(
                              onPressed: () {
                                removeFromBookmark(
                                    currentProduct.id, currentUser, context);
                                setState(() {
                                  bookmarkExists = bookmark.products.indexWhere(
                                      (element) =>
                                          element == currentProduct.id);
                                });
                              },
                              icon: Icon(Icons.bookmark_add),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            addToCart(currentProduct, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Color(0xFF273238),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF7DEA82),
                            shape: StadiumBorder(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
