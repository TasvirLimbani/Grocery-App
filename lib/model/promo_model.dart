import 'package:cloud_firestore/cloud_firestore.dart';

class PromoModel {
  List<String> promo = [];
  List<String> value = [];

  PromoModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    promo = (data['promo'] as List).map((e) => e.toString()).toList();
    value = (data['value'] as List).map((e) => e.toString()).toList();
  }
}
