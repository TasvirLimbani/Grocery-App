import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/order_place/order_place.dart';
import 'package:grocery_app/Service/paymentService.dart';
import 'package:grocery_app/components/edit_field.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:grocery_app/model/bank_model.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/promo_model.dart';
// import 'package:stripe_payment/stripe_payment.dart';
// import 'package:http/http.dart' as http;

class CheckOut extends StatefulWidget {
  List? image;
  String? name;
  List? details;
  String? weight;
  String? id;
  int? price;
  int? unit;
  String? mrp;
  int? index;

  CheckOut(
      {this.image,
      this.name,
      this.details,
      this.weight,
      this.id,
      this.price,
      this.unit,
      this.index,
      this.mrp});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  // PaymentMethod? paymentMethod;
  Set selected1 = {};
  int currentindex = -1;
  int cardindex = 0;
  dynamic value1 = "1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Check Out",
          style: TextStyle(
              color: colors.black.withOpacity(0.6),
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.appcolor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: colors.black.withOpacity(0.6),
          ),
        ),
      ),
      body: StreamBuilder<List<BankModel>>(
        stream: DatabaseService().bank,
        builder: (context, snapshot) {
          final listdata = snapshot.data;
          if (snapshot.hasData) {
            return listdata!.isEmpty
                ? AddCard()
                : Column(
                    children: [
                      Container(
                        height: size.height * 0.27,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listdata.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cardindex = index;
                                  });
                                },
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  elevation: cardindex == index ? 5 : 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    width: size.width * 0.95,
                                    height: size.height * 0.25,
                                    decoration: BoxDecoration(
                                      color: colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: cardindex == index
                                            ? colors.appcolor
                                            : colors.black,
                                        width: 5,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 0, top: 20),
                                            child: Text(
                                              listdata[index].cardNumber,
                                              style: TextStyle(
                                                  color: colors.white,
                                                  fontSize: 18,
                                                  letterSpacing: 1,
                                                  wordSpacing: 2),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              'assets/images/chip.png',
                                              width: 50,
                                            ),
                                            Text(
                                              listdata[index].expiryDate,
                                              style: TextStyle(
                                                  color: colors.white,
                                                  fontSize: 17,
                                                  letterSpacing: 1,
                                                  wordSpacing: 2),
                                            ),
                                            Text(
                                              listdata[index].cvvCode,
                                              style: TextStyle(
                                                color: colors.white,
                                                fontSize: 18,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            listdata[index].cardHolderName,
                                            style: TextStyle(
                                                color: colors.white,
                                                fontSize: 17,
                                                letterSpacing: 1,
                                                wordSpacing: 2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Apply PromoCode",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Container(
                                  height: 30,
                                  child: DropdownButton(
                                    value: value1,
                                    underline: Container(),
                                    items: Promos.map((e) => DropdownMenuItem(
                                          child: Text(e.name),
                                          value: e.value,
                                        )).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        value1 = val;
                                      });
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: Chose1.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected1.contains(index)
                                          ? selected1.remove(index)
                                          : selected1.add(index);
                                      currentindex = -1;
                                      currentindex = index;
                                    });
                                  },
                                  child: Card(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    elevation: currentindex == index ? 5 : 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 7),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: currentindex == index
                                                ? colors.appbarcolor
                                                : Colors.white,
                                            width: 2),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Container(
                                          //   margin: EdgeInsets.only(left: 10),
                                          //   child: Text(
                                          //     "${Chose1[index].char}",
                                          //     style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 30,
                                          //       color: selected1.contains(index)
                                          //           ? primarySwatch.shade900
                                          //           : Colors.grey[700],
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   width: size.width * 0.05,
                                          // ),
                                          Container(
                                            margin: EdgeInsets.only(left: 15),
                                            child: Text(
                                              "${Chose1[index].Opstion}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: currentindex == index
                                                    ? colors.appbarcolor
                                                    : Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                          Radio(
                                            groupValue: index,
                                            value: currentindex,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    colors.appbarcolor),
                                            onChanged: (val) {
                                              setState(() {
                                                selected1.contains(index)
                                                    ? selected1.remove(index)
                                                    : selected1.add(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Text(
                        "Your Total Amount : ${widget.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SafeArea(
                                        child: Scaffold(
                                          appBar: AppBar(
                                            leading: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: colors.black
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                            title: Text(
                                              "Add New Card",
                                              style: TextStyle(
                                                  color: colors.black
                                                      .withOpacity(0.6),
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            centerTitle: true,
                                            backgroundColor: colors.appcolor,
                                          ),
                                          body: AddCard(),
                                        ),
                                      );
                                    });
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              margin: EdgeInsets.only(bottom: 0, top: 10),
                              decoration: BoxDecoration(
                                color: colors.appcolor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  // topLeft: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Text(
                                  "Add Card",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              FirebaseQuery.firebaseQuery.order({
                                'name': widget.name,
                                'id': widget.id,
                                'price': widget.price,
                                'mrp': widget.mrp,
                                'weight': widget.weight,
                                'details': widget.details,
                                'image': widget.image,
                                'unit': widget.unit,
                                'day': DateTime.now().day.toString(),
                                'month': DateTime.now().month.toString(),
                                'year': DateTime.now().year.toString(),
                              });

                              // paymentMethod = await PaymentService(
                              //         url: '', amount: widget.price!.toInt())
                              //     .createPaymentMathod();
                              // print(paymentMethod!.id);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => OrderPlace()),
                                  (route) => false);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              margin: EdgeInsets.only(bottom: 0, top: 10),
                              decoration: BoxDecoration(
                                color: colors.red.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  // topRight: Radius.circular(10),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: const Center(
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
          }
          return Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    ));
  }
}

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        CreditCardWidget(
          glassmorphismConfig:
              useGlassMorphism ? Glassmorphism.defaultConfig() : null,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
          obscureCardNumber: true,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          cardBgColor: colors.black.withOpacity(0.6),
          backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
          isSwipeGestureEnabled: true,
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
          customCardTypeIcons: <CustomCardTypeIcon>[
            CustomCardTypeIcon(
              cardType: CardType.mastercard,
              cardImage: Image.asset(
                'assets/images/master.png',
                height: 48,
                width: 48,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CreditCardForm(
                  formKey: formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumber: cardNumber,
                  cvvCode: cvvCode,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                  themeColor: Colors.blue,
                  textColor: colors.black,
                  cardNumberDecoration: InputDecoration(
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    hintStyle: TextStyle(color: colors.black),
                    labelStyle: TextStyle(color: colors.black),
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  expiryDateDecoration: InputDecoration(
                    hintStyle: TextStyle(color: colors.black),
                    labelStyle: TextStyle(color: colors.black),
                    focusedBorder: border,
                    enabledBorder: border,
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: InputDecoration(
                    hintStyle: TextStyle(color: colors.black),
                    labelStyle: TextStyle(color: colors.black),
                    focusedBorder: border,
                    enabledBorder: border,
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: InputDecoration(
                    hintStyle: TextStyle(color: colors.black),
                    labelStyle: TextStyle(color: colors.black),
                    focusedBorder: border,
                    enabledBorder: border,
                    labelText: 'Card Holder',
                  ),
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: colors.appcolor,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Text(
                      'Add Card',
                      style: TextStyle(
                        color: colors.black.withOpacity(0.6),
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseQuery.firebaseQuery.insertBank({
                        'cardNumber': cardNumber,
                        'expiryDate': expiryDate,
                        'cardHolderName': cardHolderName,
                        'cvvCode': cvvCode,
                      });
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => CheckOut()));
                    } else {
                      print('invalid!');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

class chose1 {
  int char;
  String Opstion;
  chose1({required this.char, required this.Opstion});
}

List<chose1> Chose1 = [
  chose1(char: 1, Opstion: "UPI/Netbanking"),
  chose1(char: 2, Opstion: "Pay on Delivery"),
  chose1(char: 3, Opstion: "UPI/Netbanking With Self Pikup"),
  chose1(char: 4, Opstion: "Pay on Delivery With Self Pikup"),
];

class Promo {
  String name;
  dynamic value;
  Promo({this.value, required this.name});
}

List<Promo> Promos = [
  Promo(name: "FLAT 10%", value: "1"),
  Promo(name: "FLAT 20%", value: "2"),
  Promo(name: "FLAT 30%", value: "3"),
  Promo(name: "FLAT 40%", value: "4"),
  Promo(name: "FLAT 50%", value: "5"),
];
