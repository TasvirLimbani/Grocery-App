import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grocery_app/Page/homepage/homepage.dart';
import 'package:grocery_app/constant/colors.dart';

class OrderPlace extends StatefulWidget {
  @override
  _OrderPlaceState createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/thnak.jpg"),
          Text(
            "Your Order has been\naccepted",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              primary: colors.appcolor,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              child: Text(
                'Countinue Shopping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2,
                  color: colors.black.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
