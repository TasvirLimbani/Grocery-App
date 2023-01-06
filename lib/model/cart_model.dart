import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  List<String> details = [];
  List<String> image = [];
  String name = "";
  String weight = "";
  int? price;
  int? peritemprice;
  String id = "";
  String mrp = "";
  String uid = "";
  int? unit;
  CartModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    details = (data['details'] as List).map((e) => e.toString()).toList();
    image = (data['image'] as List).map((e) => e.toString()).toList();
    id = data['id'];
    name = data['name'];
    price = data['price'];
    peritemprice = data['peritemprice'];
    weight = data['weight'];
    mrp = data['mrp'];
    unit = data['unit'];
    uid = snapshot.id;
  }
}
