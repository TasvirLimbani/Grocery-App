import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/homepage/page/cart.dart';
import 'package:grocery_app/Page/homepage/page/details.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/fruite_model.dart';
import 'package:grocery_app/model/item_model.dart';
import 'package:grocery_app/constant/colors.dart';

class AllFruits extends StatefulWidget {
  @override
  _AllFruitsState createState() => _AllFruitsState();
}

class _AllFruitsState extends State<AllFruits> {
  @override
  Widget build(BuildContext context) {
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
          "Fresh Fruits",
          style: TextStyle(
              color: colors.black.withOpacity(0.6),
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List<FruitModel>>(
          stream: DatabaseService().fruit,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            final listData = snapshot.data;
            return GridView.builder(
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              id: listData![index].id,
                              image: listData[index].images,
                              name: listData[index].name,
                              price: listData[index].price,
                              weight: listData[index].weight,
                              details: listData[index].details,
                              mrp: listData[index].mrp,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colors.white,
                              border:
                                  Border.all(color: colors.appcolor, width: 3),

                              // color: Colors.green[100]
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        listData![index].images.first,
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
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${listData[index].weight} price",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            FirebaseQuery.firebaseQuery
                                                .insertcart({
                                              'name': listData[index].name,
                                              'price': listData[index].price,
                                              'mrp': listData[index].mrp,
                                              'id': listData[index].id,
                                              'unit': listData[index].unit,
                                              'weight': listData[index].weight,
                                              'image': listData[index].images,
                                              'details':
                                                  listData[index].details,
                                            });
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          padding: EdgeInsets.all(5),
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
              },
              itemCount: listData!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 10 / 12),
            );
          }),
    ));
  }
}
