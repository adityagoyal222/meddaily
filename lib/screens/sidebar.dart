import 'package:flutter/material.dart';
import 'package:meddaily/screens/bookmark_screen.dart';
import 'package:meddaily/screens/cart_list_screen.dart';
import 'package:meddaily/screens/categories_screen.dart';
import 'package:meddaily/screens/home_screen.dart';
import 'package:meddaily/screens/order_list_screen.dart';
import 'package:meddaily/screens/user_profile_screen.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        child: Drawer(
          child: Material(
            color: Color.fromRGBO(223, 232, 237, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  color: Color.fromRGBO(187, 194, 199, 1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromRGBO(187, 194, 199, 1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          "MedDaily",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 550,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 420,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuItems(
                              text: 'Home',
                              icon: Icons.home,
                              onClicked: () => selectedItem(context, 0),
                            ),
                            menuItems(
                              text: 'Categories',
                              icon: Icons.grid_3x3,
                              onClicked: () => selectedItem(context, 2),
                            ),
                            menuItems(
                              text: 'Orders',
                              icon: Icons.notifications,
                              onClicked: () => selectedItem(context, 3),
                            ),
                            menuItems(
                              text: 'Reminders',
                              icon: Icons.search,
                              onClicked: () => selectedItem(context, 4),
                            ),
                            menuItems(
                              text: 'Bookmarks',
                              icon: Icons.bookmark,
                              onClicked: () => selectedItem(context, 5),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 26),
                      // Divider(
                      //   color: Color.fromRGBO(223, 232, 237, 1),
                      // ),
                      SizedBox(height: 16), //!The height is big not spacing
                      menuItems(
                        text: 'Cart',
                        icon: Icons.shopping_cart,
                        onClicked: () => selectedItem(context, 6),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => selectedItem(context, 7),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    color: Color.fromRGBO(187, 194, 199, 1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              child: Image.network(
                                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80'),
                            ),
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Aditya Goyal",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget menuItems({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Color.fromRGBO(39, 50, 56, 1);
  final hoverColor = Color.fromRGBO(28, 48, 38, 0.1);

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
    ),
    hoverColor: hoverColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();

  switch (index) {
    case 0:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      break;
    case 1:
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomeScreen() // Search Route,
            ),
      );
      break;
    case 2:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        ),
      );
      break;
    case 3:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => OrderListScreen(),
        ),
      );
      break;
    case 4:
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomeScreen() // Reminders Route,
            ),
      );
      break;
    case 5:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => BookmarkScreen(),
        ),
      );
      break;
    case 6:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => CartListScreen(),
        ),
      );
      break;
    case 7:
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
        ),
      );
      break;
  }
}
