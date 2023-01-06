import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/homepage/page/cart.dart';
import 'package:grocery_app/Page/homepage/page/details.dart';
import 'package:grocery_app/Page/homepage/see_all/dairy.dart';
import 'package:grocery_app/Page/homepage/see_all/drink.dart';
import 'package:grocery_app/Page/homepage/see_all/fruits.dart';
import 'package:grocery_app/Page/homepage/see_all/vegetable.dart';
import 'package:grocery_app/Page/homepage/see_all/wheat.dart';
import 'package:grocery_app/components/edit_field.dart';
import 'package:grocery_app/components/filter_drawer.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocery_app/model/dairy_model.dart';
import 'package:grocery_app/model/drink_model.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/fruite_model.dart';
import 'package:grocery_app/model/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/model/vegetable_model.dart';
import 'package:grocery_app/model/wheat_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _SearchController = TextEditingController();
  String Search = "";
  bool favorite = false;
  late String _queryText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 15, right: 10),
                child: Row(
                  children: [
                    Container(
                      width: size.width / 1.24,
                      child: CupertinoSearchTextField(
                        onChanged: (val) {
                          setState(() {
                            Search = val;
                          });
                        },
                        controller: _SearchController,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FilterDrawer()));
                        },
                        icon: Icon(Icons.filter_alt_outlined)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                    itemCount: Categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllFruits()));
                          }
                          if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllVegetable()));
                          }
                          if (index == 2) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllWheat()));
                          }
                          if (index == 3) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllDrink()));
                          }
                          if (index == 4) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllDairy()));
                          }
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: colors.white,
                                    border: Border.all(
                                        width: 2, color: colors.appcolor),
                                    borderRadius: BorderRadius.circular(200),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            Categories[index].image))),
                              ),
                            ),
                            Text("${Categories[index].name}")
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              CarouselSlider(
                items: [
                  for (int i = 0; i < carouselimages.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (i == 3) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AllVegetable()));
                        }
                      },
                      child: Container(
                        height: size.height,
                        width: size.width * 0.92,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage("${carouselimages[i]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 600),
                  viewportFraction: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fresh Fruits",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllFruits()));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(fontSize: 15, color: colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: StreamBuilder<List<FruitModel>>(
                    stream: DatabaseService().fruit,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      final listData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          id: listData[index].id,
                                          image: listData[index].images,
                                          name: listData[index].name,
                                          price: listData[index].price,
                                          unit: listData[index].unit,
                                          weight: listData[index].weight,
                                          details: listData[index].details,
                                          mrp: listData[index].mrp,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 300,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.white,
                                        border: Border.all(
                                            color: colors.appcolor, width: 1),

                                        // color: Colors.green[100]
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  listData[index].images.first,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${listData[index].name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${listData[index].unit} ${listData[index].weight} price",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${listData[index].price} Rs.",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FirebaseQuery
                                                          .firebaseQuery
                                                          .insertcart({
                                                        'name': listData[index]
                                                            .name,
                                                        'price': listData[index]
                                                            .price,
                                                        'peritemprice':
                                                            listData[index]
                                                                .price,
                                                        'mrp':
                                                            listData[index].mrp,
                                                        'id':
                                                            listData[index].id,
                                                        'unit': listData[index]
                                                            .unit,
                                                        'weight':
                                                            listData[index]
                                                                .weight,
                                                        'image': listData[index]
                                                            .images,
                                                        'details':
                                                            listData[index]
                                                                .details,
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        // borderRadius:
                                                        //     BorderRadius.circular(10),
                                                        color: colors.appcolor),
                                                    child: Icon(
                                                      Icons.add_outlined,
                                                      color: colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         favorite = !favorite;
                                //         favorite == true
                                //             ? favoritelist.add(index)
                                //             : favoritelist.removeAt(index);
                                //         print(favoritelist);
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: colors.appcolor),
                                //       child: Icon(!favorite
                                //           ? Icons.favorite_border
                                //           : Icons.favorite),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          });
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fresh Vegetables",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllVegetable()));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(fontSize: 15, color: colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: StreamBuilder<List<VegetablesModel>>(
                    stream: DatabaseService().vegetable,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      final listData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          id: listData[index].id,
                                          image: listData[index].images,
                                          name: listData[index].name,
                                          price: listData[index].price,
                                          unit: listData[index].unit,
                                          weight: listData[index].weight,
                                          details: listData[index].details,
                                          mrp: listData[index].mrp,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 300,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.white,
                                        border: Border.all(
                                            color: colors.appcolor, width: 1),

                                        // color: Colors.green[100]
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  listData[index].images.first,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${listData[index].name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${listData[index].unit} ${listData[index].weight} price",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${listData[index].price} Rs.",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FirebaseQuery
                                                          .firebaseQuery
                                                          .insertcart({
                                                        'name': listData[index]
                                                            .name,
                                                        'unit': listData[index]
                                                            .unit,
                                                        'price': listData[index]
                                                            .price,
                                                        'peritemprice':
                                                            listData[index]
                                                                .price,
                                                        'mrp':
                                                            listData[index].mrp,
                                                        'id':
                                                            listData[index].id,
                                                        'weight':
                                                            listData[index]
                                                                .weight,
                                                        'image': listData[index]
                                                            .images,
                                                        'details':
                                                            listData[index]
                                                                .details,
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        // borderRadius:
                                                        //     BorderRadius.circular(10),
                                                        color: colors.appcolor),
                                                    child: Icon(
                                                      Icons.add_outlined,
                                                      color: colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         favorite = !favorite;
                                //         favorite == true
                                //             ? favoritelist.add(index)
                                //             : favoritelist.removeAt(index);
                                //         print(favoritelist);
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: colors.appcolor),
                                //       child: Icon(!favorite
                                //           ? Icons.favorite_border
                                //           : Icons.favorite),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          });
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dairy Product",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllDairy()));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(fontSize: 15, color: colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: StreamBuilder<List<DairyModel>>(
                    stream: DatabaseService().dairy,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      final listData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          id: listData[index].id,
                                          image: listData[index].images,
                                          name: listData[index].name,
                                          price: listData[index].price,
                                          unit: listData[index].unit,
                                          weight: listData[index].weight,
                                          details: listData[index].details,
                                          mrp: listData[index].mrp,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 300,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.white,
                                        border: Border.all(
                                            color: colors.appcolor, width: 1),

                                        // color: Colors.green[100]
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  listData[index].images.first,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${listData[index].name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${listData[index].unit} ${listData[index].weight} price",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${listData[index].price} Rs.",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FirebaseQuery
                                                          .firebaseQuery
                                                          .insertcart({
                                                        'name': listData[index]
                                                            .name,
                                                        'unit': listData[index]
                                                            .unit,
                                                        'price': listData[index]
                                                            .price,
                                                        'peritemprice':
                                                            listData[index]
                                                                .price,
                                                        'mrp':
                                                            listData[index].mrp,
                                                        'id':
                                                            listData[index].id,
                                                        'weight':
                                                            listData[index]
                                                                .weight,
                                                        'image': listData[index]
                                                            .images,
                                                        'details':
                                                            listData[index]
                                                                .details,
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        // borderRadius:
                                                        //     BorderRadius.circular(10),
                                                        color: colors.appcolor),
                                                    child: Icon(
                                                      Icons.add_outlined,
                                                      color: colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         favorite = !favorite;
                                //         favorite == true
                                //             ? favoritelist.add(index)
                                //             : favoritelist.removeAt(index);
                                //         print(favoritelist);
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: colors.appcolor),
                                //       child: Icon(!favorite
                                //           ? Icons.favorite_border
                                //           : Icons.favorite),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          });
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wheat Products",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllWheat()));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(fontSize: 15, color: colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: StreamBuilder<List<WheatModel>>(
                    stream: DatabaseService().wheat,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      final listData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          id: listData[index].id,
                                          image: listData[index].images,
                                          name: listData[index].name,
                                          price: listData[index].price,
                                          unit: listData[index].unit,
                                          weight: listData[index].weight,
                                          details: listData[index].details,
                                          mrp: listData[index].mrp,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 300,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.white,
                                        border: Border.all(
                                            color: colors.appcolor, width: 1),

                                        // color: Colors.green[100]
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  listData[index].images.first,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${listData[index].name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${listData[index].unit} ${listData[index].weight} price",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${listData[index].price} Rs.",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FirebaseQuery
                                                          .firebaseQuery
                                                          .insertcart({
                                                        'name': listData[index]
                                                            .name,
                                                        'price': listData[index]
                                                            .price,
                                                        'peritemprice':
                                                            listData[index]
                                                                .price,
                                                        'unit': listData[index]
                                                            .unit,
                                                        'mrp':
                                                            listData[index].mrp,
                                                        'id':
                                                            listData[index].id,
                                                        'weight':
                                                            listData[index]
                                                                .weight,
                                                        'image': listData[index]
                                                            .images,
                                                        'details':
                                                            listData[index]
                                                                .details,
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        // borderRadius:
                                                        //     BorderRadius.circular(10),
                                                        color: colors.appcolor),
                                                    child: Icon(
                                                      Icons.add_outlined,
                                                      color: colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         favorite = !favorite;
                                //         favorite == true
                                //             ? favoritelist.add(index)
                                //             : favoritelist.removeAt(index);
                                //         print(favoritelist);
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: colors.appcolor),
                                //       child: Icon(!favorite
                                //           ? Icons.favorite_border
                                //           : Icons.favorite),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          });
                    }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cold Drinks",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllDrink()));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(fontSize: 15, color: colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: StreamBuilder<List<DrinkModel>>(
                    stream: DatabaseService().drink,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      final listData = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listData!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          id: listData[index].id,
                                          image: listData[index].images,
                                          name: listData[index].name,
                                          price: listData[index].price,
                                          unit: listData[index].unit,
                                          weight: listData[index].weight,
                                          details: listData[index].details,
                                          mrp: listData[index].mrp,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height: 300,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: colors.white,
                                        border: Border.all(
                                            color: colors.appcolor, width: 1),

                                        // color: Colors.green[100]
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Image.network(
                                                  listData[index].images.first,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${listData[index].name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${listData[index].unit} ${listData[index].weight} price",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${listData[index].price} Rs.",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      FirebaseQuery
                                                          .firebaseQuery
                                                          .insertcart({
                                                        'name': listData[index]
                                                            .name,
                                                        'unit': listData[index]
                                                            .unit,
                                                        'price': listData[index]
                                                            .price,
                                                        'peritemprice':
                                                            listData[index]
                                                                .price,
                                                        'mrp':
                                                            listData[index].mrp,
                                                        'id':
                                                            listData[index].id,
                                                        'weight':
                                                            listData[index]
                                                                .weight,
                                                        'image': listData[index]
                                                            .images,
                                                        'details':
                                                            listData[index]
                                                                .details,
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        // borderRadius:
                                                        //     BorderRadius.circular(10),
                                                        color: colors.appcolor),
                                                    child: Icon(
                                                      Icons.add_outlined,
                                                      color: colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                // Positioned(
                                //   top: 5,
                                //   left: 5,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         favorite = !favorite;
                                //         favorite == true
                                //             ? favoritelist.add(index)
                                //             : favoritelist.removeAt(index);
                                //         print(favoritelist);
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.all(5),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: colors.appcolor),
                                //       child: Icon(!favorite
                                //           ? Icons.favorite_border
                                //           : Icons.favorite),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// List<Item> listData = [
//   Item(
//       image: [
//         "assets/images/a1.jpg",
//         "assets/images/a2.jpg",
//         "assets/images/a3.jpg",
//         "assets/images/a4.jpg",
//       ],
//       name: "Apple",
//       weight: "1 KG",
//       price: 120,
//       id: "apple_1",
//       details:
//           "While we work to ensure that product information is correct, on occasion manufacturers may alter their ingredient lists. Actual product packaging and materials may contain more and/or different information than that shown on our web site. We recommend that you do not solely rely on the information presented and that you always read labels, warnings, and directions before using or consuming a product. For additional information about a product, please contact the manufacturer."),
//   Item(image: [
//     "assets/images/d1.jpg",
//     "assets/images/d2.jpg",
//     "assets/images/d3.jpg",
//     "assets/images/d4.jpg",
//     "assets/images/d5.jpg",
//   ], name: "Dragon", weight: "1 KG", price: 450, id: "dragon_1"),
//   Item(image: [
//     "assets/images/o1.jpg",
//     "assets/images/o2.jpg",
//     "assets/images/o3.jpg",
//     "assets/images/o4.jpg",
//   ], name: "Orange", weight: "1 KG", price: 140, id: "orange_1"),
//   Item(image: [
//     "assets/images/p1.jpg",
//     "assets/images/p2.jpg",
//     "assets/images/p3.jpg",
//   ], name: "Pomegranate", weight: "1 KG", price: 90, id: "pomegranate_1"),
//   Item(image: [
//     "assets/images/pi1.jpg",
//     "assets/images/pi2.jpg",
//     "assets/images/pi3.jpg",
//   ], name: "Pineapple", weight: "1 Pic", price: 150, id: "pineapple_1"),
// ];

class Categorie {
  String name;
  String image;
  Categorie({required this.name, required this.image});
}

List<Categorie> Categories = [
  Categorie(name: "Fruits", image: "assets/images/fruit.png"),
  Categorie(name: "Vegetables", image: "assets/images/vegetable.png"),
  Categorie(name: "Wheat", image: "assets/images/wheat.png"),
  Categorie(name: "Drinks", image: "assets/images/drink.png"),
  Categorie(name: "Dairy", image: "assets/images/dairy.png"),
];

List carouselimages = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTmDCDhbguRO0Rs0ENC2cY9JR2GNW_i8sWdw&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUC1UqP_qiyrbifsttVI1uECczY4mK-05xIA&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwt20ConagqxtgDJW2J0u6jltQTqdE-KjCyQ&usqp=CAU",
  "https://cdn.shopify.com/s/files/1/0401/9889/7826/files/Samall_Banner-1_875x405.jpg?v=1591364550",
  "https://d39vol41m7feya.cloudfront.net/1592565847-banner-pwa-veg2.jpg",
];
