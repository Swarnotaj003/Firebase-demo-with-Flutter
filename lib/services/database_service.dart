import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/model/item.dart';

class DatabaseService {
  /*
    Service class for connecting to Firebase Firestore DB
  */

  // Our collection reference
  final CollectionReference _itemCollection = FirebaseFirestore.instance.collection("item");

  // add item
  Future addItem(String id, String name, String category) async {
    _itemCollection.add({
      "id" : id,
      "name" : name,
      "category" : category,
    });
  }

  // fetch item list from QuerySnapshot
  List<Item> _getAllItems(QuerySnapshot snapshot)  {
    return snapshot.docs.map(
      (doc) => Item(
        docId: doc.id,
        id: doc.get('id') ?? "000", 
        name: doc.get('name') ?? "Not found!", 
        category: doc.get('category') ?? "None",
      )
    ).toList();
  }

  // get item docs stream sorted by id, starting from 101
  Stream<List<Item>> get itemList {
    return _itemCollection.orderBy('id').startAfter(['100']).snapshots().map(_getAllItems);
  }

  // delete item
  Future deleteItem(String docId) async {
    await _itemCollection.doc(docId).delete();
  }

  // count items
  Future<int> countItems() async{
    AggregateQuerySnapshot snapshot = await _itemCollection.count().get();
    return snapshot.count ?? 0;
  }
}