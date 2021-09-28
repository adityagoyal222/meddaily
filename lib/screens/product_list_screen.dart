import 'package:flutter/material.dart';
import 'package:meddaily/widgets/product/product_grid.dart';

class ProductListScreen extends StatelessWidget {
  static const routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          title: Text('First Aid'),
          actions: [],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Best Match",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20),
                    ),
                    // Text(
                    //   "<>",
                    //   style: TextStyle(color: Theme.of(context).accentColor, ),
                    // ),
                    Icon(Icons.arrow_drop_down_circle_outlined)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   "<>",
                    //   style: TextStyle(color: Theme.of(context).accentColor),
                    // ), // Will replace with icon
                    Icon(Icons.filter_list_alt),
                    Text(
                      "Filter",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10)),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:meddaily/provider/product.dart';
// import 'package:meddaily/widgets/product/product_grid.dart';
// import 'package:provider/provider.dart';

// class ProductListScreen extends StatelessWidget {
//   static const routeName = '/product-list';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Theme.of(context).accentColor,
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
//         child: AppBar(
//           backgroundColor: Theme.of(context).accentColor,
//           elevation: 0,
//           title: Text('First Aid'),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           color: Theme.of(context).primaryColor,
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Best Match",
//                       style: TextStyle(color: Theme.of(context).accentColor),
//                     ),
//                     Text(
//                       "<>",
//                       style: TextStyle(color: Theme.of(context).accentColor),
//                     ), // Will replace with icon
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "<>",
//                       style: TextStyle(color: Theme.of(context).accentColor),
//                     ), // Will replace with icon
//                     Text(
//                       "Filter",
//                       style: TextStyle(color: Theme.of(context).accentColor),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             ProductGrid(),
//           ],
//         ),
//       ),
//     );
//   }
// }
