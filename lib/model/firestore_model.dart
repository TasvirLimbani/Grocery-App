import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/model/bank_model.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:grocery_app/model/order_model.dart';
import 'package:grocery_app/model/cart_model.dart';
import 'package:grocery_app/model/dairy_model.dart';
import 'package:grocery_app/model/drink_model.dart';
import 'package:grocery_app/model/favorite_model.dart';
import 'package:grocery_app/model/fruite_model.dart';
import 'package:grocery_app/model/promo_model.dart';
import 'package:grocery_app/model/vegetable_model.dart';
import 'package:grocery_app/model/wheat_model.dart';

import 'account_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference fruitsCollection =
      FirebaseFirestore.instance.collection('Fruits');
  final CollectionReference vegetableCollection =
      FirebaseFirestore.instance.collection('Vegetable');
  final CollectionReference DairyCollection =
      FirebaseFirestore.instance.collection('Dairy');
  final CollectionReference WheatCollection =
      FirebaseFirestore.instance.collection('Wheat');
  final CollectionReference DrinkCollection =
      FirebaseFirestore.instance.collection('Drink');
  final CollectionReference CartCollection =
      FirebaseFirestore.instance.collection('Cart');
  final CollectionReference FavoriteCollection =
      FirebaseFirestore.instance.collection('Favorite');
  final CollectionReference AddressCollection =
      FirebaseFirestore.instance.collection('Address');
  final CollectionReference BankCollection =
      FirebaseFirestore.instance.collection('Bank');
  final CollectionReference OrderCollection =
      FirebaseFirestore.instance.collection('Order');
  final CollectionReference UserCollection =
      FirebaseFirestore.instance.collection('Account');
  final CollectionReference PromoCollection =
      FirebaseFirestore.instance.collection('Promo');

  Future updateFruitData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await fruitsCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future updateVegetabelData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await vegetableCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future updateDairyData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await DairyCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future updateWheatData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await WheatCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future updateDrinkData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await DrinkCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future cartData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await CartCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future orderData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
    String day,
    String month,
    String year,
  ) async {
    return await OrderCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
      'time': day,
      'month': month,
      'year': year,
    });
  }

  Future favoriteData(
    List<String> details,
    List<String> image,
    String name,
    String weight,
    int price,
    int unit,
    String id,
    String mrp,
  ) async {
    return await FavoriteCollection.doc(uid).set({
      'name': name,
      'weight': weight,
      'price': price,
      'id': id,
      'details': details,
      'image': image,
      'mrp': mrp,
      'unit': unit,
    });
  }

  Future addressData(
    String fullname,
    String mobilenumber,
    String pincode,
    String flat,
    String area,
    String landmark,
    String city,
    String state,
    String country,
  ) async {
    return await AddressCollection.doc(uid).set({
      'full_name': fullname,
      'mobile_number': mobilenumber,
      'pincode': pincode,
      'flat': flat,
      'area': area,
      'landmark': landmark,
      'city': city,
      'state': state,
      'country': country,
    });
  }

  Future bankData(
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  ) async {
    return await AddressCollection.doc(uid).set({
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
    });
  }

  Future userData(
    String image,
    String name,
    String nickname,
    String uid,
  ) async {
    return await UserCollection.doc(uid).set({
      'image': image,
      'name': name,
      'nickname': nickname,
      'uid': uid,
    });
  }

  Future promoData(
    List promo,
    List value,
  ) async {
    return await UserCollection.doc(uid).set({
      'promo': promo,
      'promo': value,
    });
  }

  Stream<List<FruitModel>> get fruit {
    return fruitsCollection.snapshots().map((e) {
      List<FruitModel> modesl = e.docs.map((et) {
        return FruitModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<VegetablesModel>> get vegetable {
    return vegetableCollection.snapshots().map((e) {
      List<VegetablesModel> modesl = e.docs.map((et) {
        return VegetablesModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<DairyModel>> get dairy {
    return DairyCollection.snapshots().map((e) {
      List<DairyModel> modesl = e.docs.map((et) {
        return DairyModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<WheatModel>> get wheat {
    return WheatCollection.snapshots().map((e) {
      List<WheatModel> modesl = e.docs.map((et) {
        return WheatModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<DrinkModel>> get drink {
    return DrinkCollection.snapshots().map((e) {
      List<DrinkModel> modesl = e.docs.map((et) {
        return DrinkModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<CartModel>> get cart {
    return CartCollection.snapshots().map((e) {
      List<CartModel> modesl = e.docs.map((et) {
        return CartModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<FavoriteModel>> get favorite {
    return FavoriteCollection.snapshots().map((e) {
      List<FavoriteModel> modesl = e.docs.map((et) {
        return FavoriteModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<AddressModel>> get address {
    return AddressCollection.snapshots().map((e) {
      List<AddressModel> modesl = e.docs.map((et) {
        return AddressModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<BankModel>> get bank {
    return BankCollection.snapshots().map((e) {
      List<BankModel> modesl = e.docs.map((et) {
        return BankModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<OrderModel>> get order {
    return OrderCollection.snapshots().map((e) {
      List<OrderModel> modesl = e.docs.map((et) {
        return OrderModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<AccountModel>> get account {
    return UserCollection.snapshots().map((e) {
      List<AccountModel> modesl = e.docs.map((et) {
        return AccountModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }

  Stream<List<PromoModel>> get promo {
    return PromoCollection.snapshots().map((e) {
      List<PromoModel> modesl = e.docs.map((et) {
        return PromoModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
    // return fruitsCollection.snapshots().map(
    //     (event) => event.docs.map((e) => FruitModel.fromSnapShort(e)).toList());
  }
}
