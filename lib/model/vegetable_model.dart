import 'package:cloud_firestore/cloud_firestore.dart';

class VegetablesModel {
  List<String> details = [];
  List<String> images = [];
  String name = "";
  String weight = "";
  int? price;
  String id = "";
  String mrp = "";
  int? unit;
  VegetablesModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    details = (data['details'] as List).map((e) => e.toString()).toList();
    images = (data['image'] as List).map((e) => e.toString()).toList();
    id = data['id'];
    name = data['name'];
    price = data['price'];
    weight = data['weight'];
    mrp = data['mrp'];
    unit = data['unit'];
  }
}
