import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseQuery {
  FirebaseQuery._();
  static final FirebaseQuery firebaseQuery = FirebaseQuery._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> insertcart(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Cart').add(data);
  }

  Future<void> insertfavorite(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Favorite').add(data);
  }

  Future<void> insertaddress(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Address').add(data);
  }

  Future<void> insertBank(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Bank').add(data);
  }

  Future<void> order(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Order').add(data);
  }

  Future<void> priceupdate(String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('Cart').doc(uid).update(data);
  }

  Future<void> chnageaccountdetals(
      String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('Account').doc(uid).update(data);
  }

  Future<void> removecart(String uid) async {
    firebaseFirestore.collection('Cart').doc(uid).delete();
  }

  Future<void> removefavorite(String uid) async {
    firebaseFirestore.collection('Favorite').doc(uid).delete();
  }

  Future<void> removeorder(String uid) async {
    firebaseFirestore.collection('Order').doc(uid).delete();
  }

  Future<void> Account(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Account').add(data);
  }
}
