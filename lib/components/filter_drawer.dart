import 'package:flutter/material.dart';
import 'package:grocery_app/Page/homepage/see_all/dairy.dart';
import 'package:grocery_app/Page/homepage/see_all/drink.dart';
import 'package:grocery_app/Page/homepage/see_all/fruits.dart';
import 'package:grocery_app/Page/homepage/see_all/vegetable.dart';
import 'package:grocery_app/Page/homepage/see_all/wheat.dart';
import 'package:grocery_app/constant/colors.dart';
import 'edit_field.dart';

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  TextEditingController _MaxMindcontroller = TextEditingController();
  bool? checkbox1 = false;
  bool? checkbox2 = false;
  bool? checkbox3 = false;
  bool? checkbox4 = false;
  TextEditingController _pricecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      "Search Filters",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Price Range",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: EditTextfild(
                        controller: _pricecontroller,
                        hint: "price",
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: EditTextfild(
                        controller: _MaxMindcontroller,
                        hint: "Min",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Others",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: checkbox1,
                          onChanged: (val) {
                            setState(() {
                              checkbox1 = val;
                            });
                          }),
                      Text(
                        "Discount",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: checkbox2,
                          onChanged: (val) {
                            setState(() {
                              checkbox2 = val;
                            });
                          }),
                      Text(
                        "Voucher",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: checkbox3,
                          onChanged: (val) {
                            setState(() {
                              checkbox3 = val;
                            });
                          }),
                      Text(
                        "Free Shipping",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: checkbox4,
                          onChanged: (val) {
                            setState(() {
                              checkbox4 = val;
                            });
                          }),
                      Text(
                        "Same Day Delivery",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Categories",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  // contentPadding: EdgeInsets.only(left: 10),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AllFruits()));
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              //  fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  leading: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3081/3081887.png",
                    width: 30,
                  ),
                  title: Text(
                    "Fruit",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                  height: 1,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  // contentPadding: EdgeInsets.only(left: 10),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllVegetable()));
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              //  fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  leading: Image.network(
                    "https://cdn-icons-png.flaticon.com/128/2329/2329903.png",
                    width: 30,
                  ),
                  title: Text(
                    "Vegetable",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                  height: 1,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  // contentPadding: EdgeInsets.only(left: 10),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AllWheat()));
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              //  fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  leading: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYM0FomXN0Vw11ZqEYgEzXdtmv8fJMCJcy7Q&usqp=CAU",
                    width: 30,
                  ),
                  title: Text(
                    "Wheat Product",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                  height: 1,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  // contentPadding: EdgeInsets.only(left: 10),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AllDairy()));
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              //  fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  leading: Image.network(
                    "https://static.thenounproject.com/png/1176637-200.png",
                    width: 30,
                  ),
                  title: Text(
                    "Dairy Product",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                  height: 1,
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                  // contentPadding: EdgeInsets.only(left: 10),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AllDrink()));
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              //  fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  leading: Image.network(
                    "https://s3.amazonaws.com/iconbros/icons/icon_pngs/000/012/080/original/chocolate-30.png?1632676388",
                    width: 30,
                  ),
                  title: Text(
                    "Cold drink",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.appcolor),
                        child: Text("Apply")),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
