import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/Page/buy_now/buy_now.dart';
import 'package:grocery_app/model/cart_model.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/item_model.dart';
import 'package:grocery_app/constant/colors.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<CartModel> cart;
  late int listindex;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<CartModel>>(
            stream: DatabaseService().cart,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final listData = snapshot.data;
                cart = listData!;
                return ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      listindex = index;
                      return cartitem(
                          index: listData[index],
                          number: index,
                          onDismiss: () {
                            setState(() {});
                          });
                    });
              } else if (snapshot.hasError) {
                return Container();
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          )),
          Container(
            margin: EdgeInsets.only(right: 10, bottom: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuyNow(
                            name: cart[listindex].name,
                            price: cart[listindex].price,
                            mrp: cart[listindex].mrp,
                            weight: cart[listindex].weight,
                            id: cart[listindex].id,
                            unit: cart[listindex].unit,
                            details: cart[listindex].details,
                            image: cart[listindex].image,
                          )));
                },
                label: Text("Buy Now"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class cartitem extends StatefulWidget {
  CartModel index;
  int? number;
  Function? onDismiss;
  cartitem({required this.index, this.number, this.onDismiss});
  @override
  _cartitemState createState() => _cartitemState();
}

class _cartitemState extends State<cartitem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("${widget.index.id}"),
      
      // onDismissed: (direction) {},
      confirmDismiss: (direction) {
        return showCupertinoDialog(
            context: context,
            builder: (BuildContext ctx) {
              return CupertinoAlertDialog(
                title: Text('Please Confirm'),
                content: Text('Are you sure to remove the Item?'),
                actions: [
                  // The "Yes" button
                  CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        FirebaseQuery.firebaseQuery
                            .removecart(widget.index.uid);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Yes'),
                    isDefaultAction: true,
                    isDestructiveAction: true,
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                    isDefaultAction: false,
                    isDestructiveAction: false,
                  )
                ],
              );
            });
      },
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: colors.white,
            )
          ],
        ),
      ),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: colors.appcolor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage("${widget.index.image.first}"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                height: 90,
                width: 1.5,
                color: colors.black,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.index.name}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text("${widget.index.unit} ${widget.index.weight} Price"),
                      SizedBox(
                        height: 2,
                      ),
                      Text("${widget.index.price} Rs."),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widget.index.unit! > 1) {
                            FirebaseQuery.firebaseQuery
                                .priceupdate(widget.index.uid, {
                              'price': widget.index.peritemprice! *
                                  (widget.index.unit! - 1),
                              'unit': widget.index.unit! - 1,
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: colors.appcolor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.index.unit}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseQuery.firebaseQuery
                            .priceupdate(widget.index.uid, {
                          'price': widget.index.peritemprice! *
                              (widget.index.unit! + 1),
                          'unit': widget.index.unit! + 1,
                        });
                        print(widget.index.unit!);
                        setState(() {
                          // widget.index.unit! + 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: colors.appcolor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add),
                      ),
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
