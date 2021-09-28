import 'package:flutter/material.dart';
import 'package:meddaily/screens/product_list_screen.dart';
import 'package:meddaily/widgets/category/category_grid.dart';
import 'package:meddaily/widgets/product/product_grid.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/category-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Center(
            child: Column(
              children: [
                Text(
                  'Categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Explore the categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          children: <Widget>[
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 600,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      // childAspectRatio: 0.75
                    ),
                    children: [
                      CategoriesCard(
                          'assets/images/first-aid.png', "First Aid"),
                      CategoriesCard('assets/images/vitamin.png', "Vitamins"),
                      CategoriesCard(
                          'assets/images/masks.png', "Covid Essentials"),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final imageText;
  final cardText;

  CategoriesCard(this.imageText, this.cardText);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 10),

      padding: EdgeInsets.all(10),
      // height: 180,
      // width: 160,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ButtonTheme(
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/product-list');
          },
          child: Stack(
            children: <Widget>[
              Image.asset(imageText),
              Center(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    cardText,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
