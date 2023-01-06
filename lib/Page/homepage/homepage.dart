import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/painting.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/buy_now/buy_now.dart';
import 'package:grocery_app/Page/homepage/page/cart.dart';
import 'package:grocery_app/Page/homepage/page/favorite.dart';
import 'package:grocery_app/Page/homepage/page/home.dart';
import 'package:grocery_app/components/common_appbar.dart';
import 'package:grocery_app/components/custom_drawer.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart'; // TODO:
import 'package:grocery_app/model/cart_model.dart';

class HomePage extends StatefulWidget {
  User? user;
  int? index = 0;
  HomePage({this.user, this.index});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int botttomindex = 0;
  int _page = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Center(
    //     child: const Text("home 1"),
    //   ),
    // );
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: colors.black.withOpacity(0.6),
          ),
          onPressed: () {
            setState(() {
              _scaffoldKey.currentState!.openDrawer();
            });
          },
        ),
        backgroundColor: colors.appcolor,
        centerTitle: true,
        title: Column(
          children: [
            if (botttomindex == 0)
              Text(
                "HomePage",
                style: TextStyle(
                    color: colors.black.withOpacity(0.6),
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            if (botttomindex == 1)
              Text(
                "Your Cart",
                style: TextStyle(
                    color: colors.black.withOpacity(0.6),
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            if (botttomindex == 2)
              Text(
                "Favorite Product",
                style: TextStyle(
                    color: colors.black.withOpacity(0.6),
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
        actions: [
          // if (botttomindex == 1)
          //   // IconButton(
          //   //     onPressed: () {
          //   //       setState(() {});
          //   //       setState(() {
          //   //         Navigator.of(context)
          //   //             .pushReplacement(MaterialPageRoute(
          //   //                 builder: (context) => HomePage()))
          //   //             .then((value) => botttomindex = 1);
          //   //       });
          //   //     },
          //   //     icon: Icon(
          //   //       Icons.sync,
          //   //       color: colors.black.withOpacity(0.6),
          //   //     )),
          // if (botttomindex == 2)
          //   // Container(
          //   //   margin: EdgeInsets.only(right: 10),
          //   //   child: PopupMenuButton(
          //   //     shape: BeveledRectangleBorder(
          //   //       borderRadius: BorderRadius.circular(15),
          //   //     ),
          //   //     child: Icon(
          //   //       Icons.more_vert,
          //   //       color: colors.black.withOpacity(0.6),
          //   //     ),
          //   //     itemBuilder: (context) {
          //   //       return List.generate(Favoritepopuplist.length, (index) {
          //   //         return PopupMenuItem(
          //   //           child: Column(
          //   //             children: [
          //   //               Text('${Favoritepopuplist[index]}'),
          //   //               Divider(),
          //   //             ],
          //   //           ),
          //   //           onTap: () {
          //   //             if (index == 0)
          //   //               setState(() {
          //   //                 FavoriteItem.clear();
          //   //               });
          //   //             if (index == 1)
          //   //               Fluttertoast.showToast(
          //   //                 msg:
          //   //                     'Your Cart Total Item Is ${FavoriteItem.length}',
          //   //                 toastLength: Toast.LENGTH_SHORT,
          //   //                 gravity: ToastGravity.CENTER,
          //   //               );
          //   //           },
          //   //         );
          //   //       });
          //   //     },
          //   //   ),
          //   // ),
        ],
      ),
      drawer: CustomDrawer(
        userCredential: widget.user,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: Colors.transparent,
        color: colors.appcolor,
        items: <Widget>[
          Icon(
            botttomindex == 0 ? Icons.home : Icons.home_outlined,
            size: 30,
          ),
          Icon(
            botttomindex == 1
                ? Icons.shopping_cart
                : Icons.shopping_cart_outlined,
            size: 30,
          ),
          Icon(botttomindex == 2 ? Icons.favorite : Icons.favorite_border,
              size: 30),
        ],
        onTap: (index) {
          setState(() {
            botttomindex = index;
          });
        },
      ),
      body:
          // botttomindex == 0
          //     ? Column(
          //       children: [
          //         // if (botttomindex == 0) Home(),
          //         // if (botttomindex == 1) Cart(),
          //         // if (botttomindex == 2) Favorite(),
          //       ],
          //     )
          //     :
          Column(
        children: [
          if (botttomindex == 0) Home(),
          if (botttomindex == 1) Cart(),
          if (botttomindex == 2) Favorite(),
        ],
      ),
    ));
  }
}

List Cartpopuplist = [
  "Clear Cart",
  "Cart Item",
];

List Favoritepopuplist = [
  "Clear Favorite",
  "Favorite Item",
];
