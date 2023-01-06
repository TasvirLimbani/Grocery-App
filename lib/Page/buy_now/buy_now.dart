import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/chaeck_out/check_out.dart';
import 'package:grocery_app/components/edit_field.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:grocery_app/model/firestore_model.dart';

class BuyNow extends StatefulWidget {
  List? image;
  String? name;
  List? details;
  String? weight;
  String? id;
  int? price;
  int? unit;
  String? mrp;
  int? index;

  BuyNow(
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
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  Set selected1 = {};
  int index1 = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: colors.appcolor,
        centerTitle: true,
        title: Text(
          "Choose Address",
          style: TextStyle(
              color: colors.black.withOpacity(0.6),
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
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
      body: StreamBuilder<List<AddressModel>>(
        stream: DatabaseService().address,
        builder: (context, snapshot) {
          final listdata = snapshot.data;
          if (snapshot.hasData) {
            return listdata!.isEmpty
                ? Addaddress()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: listdata.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index1 = index;
                                    print(index1);
                                    selected1.contains(index)
                                        ? selected1.remove(index)
                                        : selected1.add(index);
                                  });
                                },
                                child: Card(
                                  elevation: index == index1 ? 5 : 0,
                                  margin: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: index1 == index
                                                ? colors.appcolor
                                                : Colors.white,
                                            width: 2),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Radio(
                                            groupValue: index,
                                            value: index1,
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${listdata[index].fullname}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    letterSpacing: 1),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${listdata[index].flat} / ${listdata[index].area}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              Text(
                                                '${listdata[index].landmark}, ${listdata[index].city}, ${listdata[index].state},',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              Text(
                                                '${listdata[index].pincode} - ${listdata[index].state}.',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              Text(
                                                'Phone Number: ${listdata[index].mobilenumber}.',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
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
                                            title: Text(
                                              "Add New Address",
                                              style: TextStyle(
                                                  color: colors.black
                                                      .withOpacity(0.6),
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            centerTitle: true,
                                            backgroundColor: colors.appcolor,
                                          ),
                                          body: Addaddress(),
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
                                  "Add Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckOut(
                                          id: widget.id,
                                          mrp: widget.mrp,
                                          details: widget.details,
                                          image: widget.image,
                                          name: widget.name,
                                          price: widget.price,
                                          unit: widget.unit,
                                          weight: widget.weight,
                                          index: widget.index,
                                        )));
                              });
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
                                  "Check out",
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
      // Addaddress()
    ));
  }
}

class Addaddress extends StatefulWidget {
  @override
  _AddaddressState createState() => _AddaddressState();
}

class _AddaddressState extends State<Addaddress> {
  GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  dynamic currentValue = "1";
  TextEditingController _fullname = TextEditingController();
  TextEditingController _mobilenumber = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _flatnumber = TextEditingController();
  TextEditingController _area = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _requirement = TextEditingController();

  String fullname = '';
  String mobilenumber = '';
  String pincode = '';
  String flatnumber = '';
  String area = '';
  String city = '';
  String landmark = '';
  String state = '';
  String country = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _Formkey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Add a new address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: colors.appcolor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Center(
                          child: CountryCodePicker(
                            onChanged: (val) {
                              setState(() {
                                country = val as String;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'In',
                            favorite: ['India'],
                            builder: (c) {
                              return Text("${c?.name}");
                            },
                            // optional. Shows only country name and flag
                            showCountryOnly: true, showDropDownButton: true,
                            showFlag: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,

                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                        // DropdownButton(
                        //   isExpanded: true,
                        //   underline: Container(),
                        //   items: [
                        //     DropdownMenuItem(
                        //       child: Center(child: Text("You Move Me")),
                        //       value: "1",
                        //     ),
                        //     DropdownMenuItem(
                        //       child: Text("You Move Me 2"),
                        //       value: "2",
                        //     ),
                        //   ],
                        //   value: currentValue,
                        //   onChanged: (v) {
                        //     currentValue = v;
                        //     setState(() {});
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _fullname,
                    hint: "Full Name",
                    onsaved: (val) {
                      fullname = val!;
                    },
                    textinput: TextInputAction.next,
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Full Name";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _mobilenumber,
                    hint: "Mobile Number",
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      mobilenumber = val!;
                    },
                    number: 10,
                    keybordtype: TextInputType.number,
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Mobile Number";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _pincode,
                    hint: "Pin Code",
                    number: 6,
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      pincode = val!;
                    },
                    keybordtype: TextInputType.number,
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Pin Code";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _flatnumber,
                    hint: "Flat Number,House Number",
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      flatnumber = val!;
                    },
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Flat Number,House Number";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _area,
                    hint: "Area, Colony, Street, Village",
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      area = val!;
                    },
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Area, Colony, Street, Village";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _landmark,
                    hint: "Landmark e.g. near Apollo Hospital",
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      landmark = val!;
                    },
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Landmark";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _city,
                    hint: "Town/City",
                    textinput: TextInputAction.next,
                    onsaved: (val) {
                      city = val!;
                    },
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter Town/City";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _state,
                    hint: "State",
                    textinput: TextInputAction.done,
                    onsaved: (val) {
                      state = val!;
                    },
                    Border: OutlineInputBorder(),
                    validator: (val) {
                      if (val!.isEmpty || val == "" || val == " ") {
                        return "Enter State";
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  EditTextfild(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    controller: _requirement,
                    hint: "Special Requirement",
                    textinput: TextInputAction.done,
                    Border: OutlineInputBorder(),
                    // validator: (val) {
                    //   if (val!.isEmpty || val == "" || val == " ") {
                    //     return "Enter Your Requirement";
                    //   }
                    // },
                  ),
                ],
              ),
            )),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_Formkey.currentState!.validate()) {
                    _Formkey.currentState!.save();
                    FirebaseQuery.firebaseQuery.insertaddress({
                      'full_name': _fullname.text,
                      'mobile_number': mobilenumber,
                      'full_name': _fullname.text,
                      'pincode': pincode,
                      'flat': _flatnumber.text,
                      'area': _area.text,
                      'landmark': _landmark.text,
                      'city': _city.text,
                      'state': _state.text,
                      'country': country,
                      'requirement': _requirement.text,
                    });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => BuyNow()));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    color: colors.appcolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    "Save Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
