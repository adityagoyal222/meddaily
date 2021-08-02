import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meddaily/db/cart_db.dart';
import 'package:meddaily/db/product_db.dart';
import 'package:meddaily/db/user_db.dart';
import 'package:meddaily/provider/cart.dart';
import 'package:meddaily/provider/product.dart';
import 'package:meddaily/screens/auth_screen.dart';
import 'package:meddaily/screens/home_screen.dart';
import 'package:meddaily/screens/product_list_screen.dart';
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
            if (FirebaseAuth.instance.currentUser != null)
              StreamProvider<List<Cart>>(
                create: (_) => CartDatabaseService()
                    .streamCarts(FirebaseAuth.instance.currentUser!),
                initialData: [],
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
            },
          ),
        );
      },
    );
  }
}
