import 'package:flutter/material.dart';
import 'package:meddaily/provider/category.dart';
import 'package:meddaily/widgets/category/category_item.dart';
import 'package:provider/provider.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loadedCategories = Provider.of<List<Category>>(context);
    return Container(
      height: 550,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _loadedCategories.length,
        itemBuilder: (ctx, i) => (CategoryItem(_loadedCategories[i])),
      ),
    );
  }
}
