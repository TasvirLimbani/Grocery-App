import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String fullname = "";
  String? mobilenumber;
  String? pincode;
  String? flat = "";
  String? area = "";
  String? landmark = "";
  String? city = "";
  String? state = "";
  String? country = "";
  String uid = "";
  String requirement = "";
  AddressModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    // print(data.toString());
    fullname = data["full_name"];
    mobilenumber = data["mobile_number"];
    pincode = data["pincode"];
    flat = data["flat"];
    area = data["area"];
    landmark = data["landmark"];
    city = data["city"];
    state = data["state"];
    country = data["country"];
    requirement = data["requirement"];
    uid = snapshot.id;
  }
}
