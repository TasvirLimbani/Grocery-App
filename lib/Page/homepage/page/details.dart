import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/buy_now/buy_now.dart';
import 'package:grocery_app/Page/homepage/page/cart.dart';
import 'package:grocery_app/Page/homepage/page/favorite.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:grocery_app/model/item_model.dart';
// import 'package:fluttertoast/fluttertoast.dart'; // TODO:

class DetailsPage extends StatefulWidget {
  List? image;
  String? name;
  List? details;
  String? weight;
  String? id;
  int? price;
  int? unit;
  String? mrp;
  int? index;

  DetailsPage(
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
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool favorite = false;
  CarouselController carouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Colors.green[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, top: 30),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: colors.black,
                      )),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Spacer(),
              Card(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(50, 20),
                    topLeft: Radius.elliptical(50, 20),
                  ),
                ),
                child: Container(
                    height: size.height * 0.85,
                    width: size.width,
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          child: ListView.builder(
                              itemCount: widget.details!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 8, left: 10, right: 10),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colors.grey),
                                        ),
                                        Container(
                                            width: size.width * 0.87,
                                            child: Text(
                                                "${widget.details![index]}"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 60),
                        ),
                      ],
                    )),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Center(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    // overflow: TextOverflow.visible,
                    children: [
                      Container(
                        width: size.width / 1.2,
                        height: size.height * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //color: Colors.red,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: CarouselSlider(
                                carouselController: carouselController,
                                items: [
                                  for (int i = 0; i < widget.image!.length; i++)
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${widget.image![i]}"),
                                            ),
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 10,
                                        //   left: 10,
                                        //   child: Image.asset(
                                        //     'assets/images/logo.png',
                                        //     width: 60,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                ],
                                options: CarouselOptions(
                                    height: 240.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 600),
                                    viewportFraction: 1,
                                    onPageChanged: (index, _) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: 55,  
                              child: ListView.builder(
                                  itemCount: widget.image!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      height: _current == index ? 9 : 6,
                                      width: _current == index ? 9 : 6,
                                      decoration: BoxDecoration(
                                        color: _current == index
                                            ? colors.green
                                            : colors.appcolor,
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                            ),
                            Spacer(),
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${widget.unit} ${widget.weight} Price",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.price} RS.",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${widget.mrp} Rs",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: colors.grey,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: -10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              favorite = !favorite;
                            });
                            FirebaseQuery.firebaseQuery.insertfavorite({
                              'name': widget.name,
                              'price': widget.price,
                              'mrp': widget.mrp,
                              'id': widget.id,
                              'weight': widget.weight,
                              'image': widget.image,
                              'unit': widget.unit,
                              'details': widget.details,
                            });
                            // !favorite
                            //     ? Fluttertoast.showToast(
                            //         msg: 'Remove Form Favorite List',
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.TOP,
                            //       )
                            //     : Fluttertoast.showToast(
                            //         msg: 'This Item Is Your Favorite..',
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.TOP,
                            //       );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: colors.appcolor),
                            child: Icon(
                              Icons.favorite,
                              color: !favorite ? colors.white : colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      setState(() {
                        FirebaseQuery.firebaseQuery.insertcart({
                          'name': widget.name,
                          'price': widget.price,
                          'mrp': widget.mrp,
                          'id': widget.id,
                          'weight': widget.weight,
                          'image': widget.image,
                          'unit': widget.unit,
                          'peritemprice': widget.price,
                          'details': widget.details,
                        });
                      });
                      // Fluttertoast.showToast(
                      //   msg: 'Item Is Add To Cart..',
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      // );
                    });
                  },
                  child: Container(
                    width: size.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add To Cart",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BuyNow(
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
                    width: size.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
