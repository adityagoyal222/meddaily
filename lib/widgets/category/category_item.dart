import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final loadedCategory;

  CategoryItem(this.loadedCategory);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.grey,
        height: 100,
        child: Text(
          loadedCategory.name,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
