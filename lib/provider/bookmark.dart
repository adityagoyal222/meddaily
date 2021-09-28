import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmark {
  final String id;
  final List<String> products;

  Bookmark({required this.id, required this.products});

  factory Bookmark.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<dynamic, dynamic>;
    print("bookmark data ${data}");
    return Bookmark(id: doc.id, products: List.from(doc['products']));
  }
}
