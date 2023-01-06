import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  String image = "";
  String name = "";
  String nickname = "";
  String? uid;
  AccountModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    image = data["image"];
    name = data["name"];
    nickname = data["nickname"];
    uid = snapshot.id;
  }
}
