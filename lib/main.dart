import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/auth_user_db.dart';
import 'package:meddaily/db/bookmark_db.dart';
import 'package:meddaily/db/cart_db.dart';
import 'package:meddaily/db/category_db.dart';
import 'package:meddaily/db/order_db.dart';
import 'package:meddaily/db/product_db.dart';
import 'package:meddaily/db/user_db.dart';
import 'package:meddaily/provider/auth_user.dart';
import 'package:meddaily/provider/bookmark.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/category.dart';
import 'package:meddaily/provider/order.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/screens/auth_screen.dart';
import 'package:meddaily/screens/bookmark_screen.dart';
import 'package:meddaily/screens/cart_list_screen.dart';
import 'package:meddaily/screens/categories_screen.dart';
import 'package:meddaily/screens/home_screen.dart';
import 'package:meddaily/screens/order_list_screen.dart';
import 'package:meddaily/screens/product_detail_screen.dart';
import 'package:meddaily/screens/product_list_screen.dart';
import 'package:meddaily/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch as Map<int, Color>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error Occurred"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return MultiProvider(
          providers: [
            StreamProvider<List<Product>>(
              create: (_) => ProductDatabaseService().streamProducts(),
              initialData: [],
            ),
            StreamProvider<List<Category>>(
              create: (_) => CategoryDatabaseService().streamCategory(),
              initialData: [],
            ),
            if (FirebaseAuth.instance.currentUser != null)
              StreamProvider<List<Cart>>(
                create: (_) => CartDatabaseService()
                    .streamCarts(FirebaseAuth.instance.currentUser!),
                initialData: [],
              ),
            if (FirebaseAuth.instance.currentUser != null)
              StreamProvider<List<Order>>(
                create: (_) => OrderDatabaseService()
                    .streamOrders(FirebaseAuth.instance.currentUser!),
                initialData: [],
              ),
            if (FirebaseAuth.instance.currentUser != null)
              StreamProvider<List<Bookmark>>(
                create: (_) => BookmarkDatabaseService()
                    .streamBookmarks(FirebaseAuth.instance.currentUser!),
                initialData: [],
              ),
            if (FirebaseAuth.instance.currentUser != null)
              StreamProvider<AuthUser>(
                create: (_) => AuthUserDatabaseService(
                        FirebaseAuth.instance.currentUser!.uid)
                    .userData,
                initialData: AuthUser(
                    email: '', name: '', uid: '', userType: UserType.Customer),
              )
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: buildMaterialColor(Color(0XFFEBF3F9)),
              accentColor: Color(0XFF273238),
              fontFamily: 'Poppins',
              primaryTextTheme: TextTheme(
                headline6: TextStyle(
                  color: Color(0XFFEBF3F9),
                ),
                headline5: TextStyle(
                  color: Color(0XFF273238),
                ),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Color(0XFF7DEA82),
                disabledColor: Colors.grey,
              ),
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  return HomeScreen();
                }
                return AuthScreen();
              },
            ),
            routes: {
              ProductListScreen.routeName: (ctx) => ProductListScreen(),
              CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
              UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartListScreen.routeName: (ctx) => CartListScreen(),
              OrderListScreen.routeName: (ctx) => OrderListScreen(),
              BookmarkScreen.routename: (ctx) => BookmarkScreen(),
            },
          ),
        );
      },
    );
  }
}
