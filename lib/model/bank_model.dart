import 'package:cloud_firestore/cloud_firestore.dart';

class BankModel {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String uid = '';

  BankModel.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    cardNumber = data['cardNumber'];
    expiryDate = data['expiryDate'];
    cardHolderName = data['cardHolderName'];
    cvvCode = data['cvvCode'];
    uid = snapshot.id;
  }
}
