import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/model/favorite_model.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/item_model.dart';
import 'package:grocery_app/constant/colors.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
        child: StreamBuilder<List<FavoriteModel>>(
      stream: DatabaseService().favorite,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final listData = snapshot.data;

          return
              // listData!.isEmpty
              //   ? Expanded(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Center(child: Image.asset('assets/images/no_data.png')),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Text(
              //             "No Item have been placed yet.\nDiscover and Favorite now",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 16,
              //                 wordSpacing: 2,
              //                 color: colors.grey),
              //           ),
              //         ],
              //       ),
              //     )
              //   :
              ListView.builder(
                  itemCount: listData!.length,
                  itemBuilder: (context, index) {
                    return favoriteitem(
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
    ));
  }
}

class favoriteitem extends StatefulWidget {
  FavoriteModel index;
  int? number;
  Function? onDismiss;

  favoriteitem({required this.index, this.number, this.onDismiss});

  @override
  _favoriteitemState createState() => _favoriteitemState();
}

class _favoriteitemState extends State<favoriteitem> {
  int weights = 1;

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
                            .removefavorite(widget.index.uid);
                        widget.onDismiss!();
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
                        widget.index.name,
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
                      Text("${widget.index.weight} Price"),
                      SizedBox(
                        height: 2,
                      ),
                      Text("${widget.index.price} Rs."),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
