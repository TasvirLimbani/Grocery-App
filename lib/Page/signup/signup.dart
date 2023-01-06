import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_helper.dart';
import '../login/login.dart';
import 'package:grocery_app/constant/colors.dart';
import '../../components/edit_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart'; //TODO:

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _Usernamecontroller = TextEditingController();
  TextEditingController _Phonenumbercontroller = TextEditingController();
  TextEditingController _Passwordcontroller = TextEditingController();
  String username = "";
  String password = "";
  String usenameerror = "";
  String passworderror = "";
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
                    "Getting Started",
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
                    "Create an account to continued",
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
                  padding: const EdgeInsets.only(bottom: 0, top: 30),
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
                              hint: "Username",
                              onsaved: (val) {
                                username = val!;
                              },
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
                              margin: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Phone Number",
                                style:
                                    TextStyle(color: colors.grey, fontSize: 10),
                              ),
                            ),
                            EditTextfild(
                              controller: _Phonenumbercontroller,
                              validator: (val) {
                                if (val!.isEmpty || val == "" || val == " ") {
                                  return "Plases Enter Phone Number";
                                }
                              },
                              number: 10,
                              keybordtype: TextInputType.number,
                              hint: "Phone Number",
                              prefixicon: const Icon(Icons.phone),
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
                              onsaved: (val) {
                                password = val!;
                              },
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
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    _globalKey.currentState!.save();
                                    try {
                                      User? user = await FirebaseHelper.Auth
                                          .RagisterwithEmailandPassword(
                                              _Usernamecontroller.text,
                                              _Passwordcontroller.text);

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      // switch (e.code) {
                                      //   case "The account already exists for that email":
                                      //     setState(() {
                                      //       usenameerror =
                                      //           "The account already exists for that email";
                                      //     });
                                      //     break;
                                      //   case "weak-password":
                                      //     Fluttertoast.showToast(
                                      //       msg: 'Your Password is Week',
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
                                      // } TODO:
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
                                      "Sign Up",
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
                                  Text("I have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      "Sign In",
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
