import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  List<String> details = [];
  List<String> image = [];
  String name = "";
  String weight = "";
  int? price;
  String id = "";
  String mrp = "";
  String uid = "";
  int? unit;
  FavoriteModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    details = (data['details'] as List).map((e) => e.toString()).toList();
    image = (data['image'] as List).map((e) => e.toString()).toList();
    id = data['id'];
    name = data['name'];
    price = data['price'];
    weight = data['weight'];
    mrp = data['mrp'];
    unit = data['unit'];
    uid = snapshot.id;
  }
}
