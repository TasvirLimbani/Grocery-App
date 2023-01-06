import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/Page/login/login.dart';
import 'splash_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../homepage/homepage.dart';

class splash_screen extends StatefulWidget {
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  visited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool visit = preferences.getBool('counter') ?? false;
    preferences.getString(useremail);
    preferences.getString(useruid);
    preferences.getString(usernickname);
    preferences.getString(userphoto);
    preferences.getString(userphonenumber);
    final timer = Timer(
      Duration(seconds: 3),
      () {
        print("method called" + visit.toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => !visit ? splsh_screen2() : HomePage(),
            ),
            (route) => false);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visited();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image(
              image: AssetImage("assets/images/plant2.png"),
              width: 300,
            ),
          ),
          Center(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image(
              image: AssetImage("assets/images/fruits.png"),
            ),
          ),
        ],
      ),
    );
  }
}
