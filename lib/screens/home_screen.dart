import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meddaily/screens/bookmark_screen.dart';
import 'package:meddaily/screens/cart_list_screen.dart';
import 'package:meddaily/screens/categories_screen.dart';
import 'package:meddaily/screens/order_list_screen.dart';
import 'package:meddaily/screens/product_list_screen.dart';
import 'package:meddaily/screens/sidebar.dart';
import 'package:meddaily/screens/user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();
              try {
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("error"),
                    backgroundColor: Theme.of(context).errorColor,
                  ),
                );
              }
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      drawer: Sidebar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Your Medications",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "see more >",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Anitbiotics"),
                              Icon(Icons.medication)
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text("Ayurvedic"),
                              Icon(Icons.medication)
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage("assets/images/advert.png"),
                ),
              ),
            ),
            Container(
              height: 440,
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Covid Essentals",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "see more >",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    // child: GridView.builder(
                    //   itemCount: 4,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemBuilder: (context, index) => ItemCard(),
                    // ),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: [
                        ItemCard('assets/images/masks.png', 'Mask', 'Rs.15'),
                        ItemCard('assets/images/faceshield.jpeg', 'Face Shield',
                            'Rs.50'),
                        ItemCard(
                            'assets/images/ppekit.jpg', 'PPE Kit', 'Rs.2000'),
                        ItemCard('assets/images/sanitizer.jpg', 'Sanitizer',
                            'Rs.200'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final imageText;
  final cardText;
  final price;

  ItemCard(this.imageText, this.cardText, this.price);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Column(
        children: [
          Image(
            image: AssetImage(imageText),
            height: 100,
            width: 100,
          ),
          SizedBox(height: 5),
          Text(
            cardText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          Text(
            price,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
