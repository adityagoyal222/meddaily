import 'package:flutter/material.dart';
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
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).accentColor,
        ),
        child: CategoryGrid(),
      ),
    );
  }
}
