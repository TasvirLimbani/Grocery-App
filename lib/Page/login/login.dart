import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_helper.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/routes/routes.dart';
import '../homepage/homepage.dart';
import '../signup/signup.dart';
import 'package:grocery_app/constant/colors.dart';
import '../../components/edit_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart'; //TODO:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String useremail = "useremail";
String userphonenumber = "userphonenumber";
String userphoto = "userphoto";
String useruid = "useruid";
String usernickname = "usernickname";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _Usernamecontroller = TextEditingController();
  TextEditingController _Passwordcontroller = TextEditingController();

  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.appcolor,
      body: Form(
        key: _globalKey,
        child: Stack(
          children: [
            Container(
              // margin: EdgeInsets.only(top: size.height * 0.1),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: size.width * 0.6,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Let's Sign You In",
                    style: TextStyle(
                        color: colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Welcome back ,You've been missed",
                    style: TextStyle(
                        color: colors.grey,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0, top: 15),
                  width: size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: colors.grey, spreadRadius: 0, blurRadius: 10)
                      ],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: colors.white),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Username or E-Mail",
                                style:
                                    TextStyle(color: colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Usernamecontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter E-mail Adderss";
                                }
                              },
                              keybordtype: TextInputType.emailAddress,

                              hint: "Username",
                              prefixicon: const Icon(Icons.person),
                              // suffixicon: Icon(
                              //   Icons.done,
                              //   color: colors.green,
                              // ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                "Password",
                                style:
                                    TextStyle(color: colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Passwordcontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter Password";
                                }
                              },
                              hint: "Password",
                              prefixicon: Icon(
                                Icons.lock_outlined,
                              ),
                              suffixicon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidepassword = !hidepassword;
                                  });
                                },
                                icon: Icon(
                                  hidepassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: colors.green,
                                ),
                              ),
                              passwordshow: hidepassword,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text("Forgot Password?")),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(FontAwesomeIcons.google),
                              label: Text("Google"),
                              onPressed: () async {
                                UserCredential? userCredential =
                                    await FirebaseHelper.Auth
                                        .signInWithGoogle();
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                await prefs.setString(
                                  useremail,
                                  userCredential.user!.email.toString(),
                                );
                                await prefs.setString(
                                    usernickname,
                                    userCredential.user!.displayName
                                        .toString());
                                await prefs.setString(
                                  userphoto,
                                  userCredential.user!.photoURL.toString(),
                                );
                                await prefs.setString(
                                  useruid,
                                  userCredential.user!.uid.toString(),
                                );
                                bool visit = prefs.getBool('counter') ?? true;
                                await prefs.setBool('counter', visit);
                                FirebaseQuery.firebaseQuery.Account({
                                  'name': userCredential.user!.email,
                                  'image': userCredential.user!.photoURL,
                                  'nickname': userCredential.user!.displayName,
                                  'uid': userCredential.user!.uid,
                                });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              user: userCredential.user,
                                            )),
                                    (route) => false);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    colors.appbarcolor),
                                overlayColor:
                                    MaterialStateProperty.all(colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(FontAwesomeIcons.facebook),
                              label: Text("Facebook"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    colors.appbarcolor),
                                overlayColor:
                                    MaterialStateProperty.all(colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    _globalKey.currentState!.save();
                                    try {
                                      User? user = await FirebaseHelper.Auth
                                          .LoginwithEmailandPassword(
                                              _Usernamecontroller.text,
                                              _Passwordcontroller.text);
                                      setState(() {});
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                        useremail,
                                        user!.email.toString(),
                                      );
                                      await prefs.setString(usernickname,
                                          user.displayName.toString());
                                      await prefs.setString(
                                        userphoto,
                                        user.photoURL.toString(),
                                      );
                                      await prefs.setString(
                                        useruid,
                                        user.uid.toString(),
                                      );
                                      bool visit =
                                          prefs.getBool('counter') ?? true;
                                      await prefs.setBool('counter', visit);
                                      FirebaseQuery.firebaseQuery.Account({
                                        'name': _Usernamecontroller.text,
                                        'pasword': _Passwordcontroller.text,
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    user: user,
                                                  )),
                                          (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      // switch (e.code) {
                                      //   case "user-not-found":
                                      //     Fluttertoast.showToast(
                                      //       msg:
                                      //           'No user found for that email.',
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.BOTTOM,
                                      //     );
                                      //     break;
                                      //   case "wrong-password":
                                      //     Fluttertoast.showToast(
                                      //       msg:
                                      //           'Wrong password provided for that user.',
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.BOTTOM,
                                      //     );
                                      //     break;
                                      //   default:
                                      //     Fluttertoast.showToast(
                                      //       msg: e.code,
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.BOTTOM,
                                      //     );
                                      // }
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: colors.green),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
