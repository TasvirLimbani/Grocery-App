import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_helper.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/about_us/about_us.dart';
import 'package:grocery_app/Page/account_setting/account_setting.dart';
import 'package:grocery_app/Page/your_order/your_order.dart';
import 'package:grocery_app/components/edit_field.dart';
import 'package:grocery_app/model/account_model.dart';
import 'package:grocery_app/model/firestore_model.dart';
import '../Page/help_center/help_center.dart';
import 'package:grocery_app/Page/homepage/homepage.dart';
import 'package:grocery_app/Page/homepage/page/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Page/login/login.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:grocery_app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatefulWidget {
  User? userCredential;
  CustomDrawer({this.userCredential});
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.userCredential;
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30), color: Colors.green
          border: Border.all(
            width: 5,
            color: colors.appcolor,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: StreamBuilder<List<AccountModel>>(
                      stream: DatabaseService().account,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final listData = snapshot.data;
                          return ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: colors.appbarcolor,
                                              shape: BoxShape.circle),
                                          child: CircleAvatar(
                                            radius: 70,
                                            backgroundImage: listData![index]
                                                        .image !=
                                                    null
                                                ? NetworkImage(
                                                    listData[index].image)
                                                : NetworkImage(
                                                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              Alert(
                                                  context: context,
                                                  title: "Change Info",
                                                  content: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      EditTextfild(
                                                        controller: _name,
                                                        Border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                )),
                                                        hint: "Name",
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 10),
                                                        prefixicon:
                                                            Icon(Icons.person),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  buttons: [
                                                    DialogButton(
                                                      onPressed: () {
                                                        FirebaseQuery
                                                            .firebaseQuery
                                                            .chnageaccountdetals(
                                                                listData[index]
                                                                    .uid
                                                                    .toString(),
                                                                {
                                                              'nickname':
                                                                  _name.text,
                                                            });
                                                        print(listData[index]
                                                            .uid);
                                                        Navigator.pop(context);
                                                        _email.clear();
                                                        _name.clear();
                                                      },
                                                      child: Text(
                                                        "CHANGE",
                                                        style: TextStyle(
                                                            color: colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                            fontSize: 20),
                                                      ),
                                                    )
                                                  ]).show();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: colors.appbarcolor,
                                                      width: 2)),
                                              padding: EdgeInsets.all(4),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit_outlined,
                                                  color: colors.appbarcolor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        listData[index].nickname != null
                                            ? Text(
                                                "${listData[index].nickname}")
                                            : Text("Guest"),
                                        Text("${listData[index].name}"),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        }
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Draweritems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          if (index == 0) {
                            Navigator.of(context).pop();
                          }
                          if (index == 2) {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Order()));
                          }
                          if (index == 4) {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Setting(
                                      user: widget.userCredential,
                                    )));
                          }
                          if (index == 5) {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AboutUs()));
                          }
                          if (index == 6) {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HelpScreen()));
                          }
                        },
                        leading: Draweritems[index].icon,
                        title: Text("${Draweritems[index].name}"),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        indent: 20,
                        // endIndent: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(
              thickness: 1,
              height: 0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                child: ListTile(
                  onTap: () async {
                    await FirebaseHelper.Auth.Signout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      // fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: colors.red,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  leading: Icon(
                    Icons.power_settings_new,
                    color: colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class draweritem {
  Icon? icon;
  String? name;

  draweritem({this.icon, this.name});
}

List<draweritem> Draweritems = [
  draweritem(icon: Icon(Icons.home_outlined), name: "Home"),
  draweritem(icon: Icon(Icons.shopping_cart_outlined), name: "My Cart"),
  draweritem(icon: Icon(Icons.inventory_2_outlined), name: "Your Order"),
  draweritem(icon: Icon(Icons.favorite_border), name: "Favorite"),
  draweritem(icon: Icon(Icons.settings_outlined), name: "Account Settings"),
  draweritem(icon: Icon(Icons.info_outlined), name: "About Us"),
  draweritem(icon: Icon(Icons.help_outline), name: "Help Center"),
];
