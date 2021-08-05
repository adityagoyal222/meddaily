import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meddaily/screens/categories_screen.dart';
import 'package:meddaily/screens/product_list_screen.dart';
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
      body: Container(
        child: Column(
          children: [
            FlatButton(
              child: Text("Products List Page"),
              onPressed: () {
                Navigator.of(context).pushNamed(ProductListScreen.routeName);
              },
            ),
            FlatButton(
              child: Text("Categories List Page"),
              onPressed: () {
                Navigator.of(context).pushNamed(CategoriesScreen.routeName);
              },
            ),
            FlatButton(
              child: Text("User Profile Page"),
              onPressed: () {
                Navigator.of(context).pushNamed(UserProfileScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
