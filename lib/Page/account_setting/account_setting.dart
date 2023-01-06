import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/model/account_model.dart';
import 'package:grocery_app/model/firestore_model.dart';

class Setting extends StatefulWidget {
  User? user;

  Setting({this.user});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colors.appcolor,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: colors.black.withOpacity(0.6),
            ),
          ),
          title: Text(
            "Account Setting",
            style: TextStyle(
                color: colors.black.withOpacity(0.6),
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: size.height * 0.2,
                    width: size.width,
                    color: colors.appcolor,
                  ),
                  Positioned(
                    bottom: -size.height * 0.075,
                    right: 0,
                    left: 0,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: size.width,
                        // height: size.height * 0.16,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.3,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 20,
                              ),
                              widget.user != null
                                  ? widget.user!.displayName != null
                                      ? Text(
                                          "${widget.user!.displayName}"
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      : Text(
                                          "${widget.user!.displayName}"
                                              .split('@')
                                              .first,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                  : const Text(
                                      "test",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                              // Text(
                              //   "${widget.user!.email}"
                              //       .split('@')
                              //       .first
                              //       .toUpperCase(),
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 18),
                              // ),
                              // Text(
                              //   "UI/UX Designer",
                              //   style: TextStyle(
                              //       color: primarySwatch[600], fontSize: 15),
                              // ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              widget.user != null
                                  ? widget.user!.email != null
                                      ? Text(
                                          "${widget.user!.email}".toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      : Text(
                                          "${widget.user!.email}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                  : const Text(
                                      "test@gmail.com",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                              Container(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -size.height * 0.05,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(left: 40),
                      child: Container(
                        height: size.height * 0.19,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: widget.user != null
                                ? widget.user!.photoURL != null
                                    ? NetworkImage("${widget.user!.photoURL}")
                                    : NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png")
                                : NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- My Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 18),
                          title: Text(
                            "Member ID",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.grey),
                          ),
                          // subtitle: Text(
                          //   "27",
                          //   style: TextStyle(
                          //       // height: 1.5,
                          //       fontWeight: FontWeight.bold,
                          //       letterSpacing: 2,
                          //       wordSpacing: 1,
                          //       color: primarySwatch[400]),
                          // ),
                          trailing: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                      color: colors.appcolor,
                                      offset: Offset(0, 1.5))
                                ]),
                            child: Text(
                              "01",
                              style: TextStyle(
                                  color: colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.005,
                    // ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "- Details:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height,
                      child: ListView.builder(
                          itemCount: Accountlists.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      leading: Accountlists[index].icon,
                                      title: Text(
                                        "${Accountlists[index].name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colors.black),
                                      ),
                                      trailing: Icon(Icons.navigate_next),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Accountlist {
  Icon? icon;
  String? name;

  Accountlist({this.name, this.icon});
}

List<Accountlist> Accountlists = [
  Accountlist(
      name: "All Notification",
      icon: Icon(
        Icons.notifications,
        color: colors.black,
      )),
  Accountlist(
      name: "Purchase History",
      icon: Icon(
        Icons.history,
        color: colors.black,
      )),
  Accountlist(
      name: "Bank Account",
      icon: Icon(
        Icons.account_balance,
        color: colors.black,
      )),
  Accountlist(
      name: "Invite & Earn",
      icon: Icon(
        Icons.redeem,
        color: colors.black,
      )),
];
