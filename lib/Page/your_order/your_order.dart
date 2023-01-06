import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Helper/firebase_query.dart';
import 'package:grocery_app/constant/colors.dart';
import 'package:grocery_app/model/firestore_model.dart';
import 'package:grocery_app/model/order_model.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: colors.appcolor,
        centerTitle: true,
        title: Text(
          "Your Orders",
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
      body: StreamBuilder<List<OrderModel>>(
        stream: DatabaseService().order,
        builder: (context, snapshot) {
          final listdata = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: listdata!.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                      index: listdata[index],
                      number: index,
                      onDismiss: () {
                        setState(() {});
                      });
                });
          }

          return Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    ));
  }
}

class OrderItem extends StatefulWidget {
  OrderModel index;
  int? number;
  Function? onDismiss;
  OrderItem({required this.index, this.number, this.onDismiss});
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  int _index = 0;
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
                            .removeorder(widget.index.uid);
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
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Card(
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
                        Text(
                            "${widget.index.unit} ${widget.index.weight} Price"),
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
        children: [
          Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails) {
              return Container();
            },
            currentStep: _index,
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: <Step>[
              Step(
                  title: Text(
                      "Order Date: ${widget.index.day} - ${month[int.parse(widget.index.month) - 1]}, ${widget.index.year}"),
                  content: Container(
                    height: 1,
                    width: 1,
                  ),
                  isActive: true),
              Step(
                title: Text(
                    "Shipped: ${int.parse(widget.index.day) + 5} - ${month[int.parse(widget.index.month) - 1]}, ${widget.index.year}"),
                content: Container(
                  height: 1,
                  width: 1,
                ),
              ),
              Step(
                title: Text("Out for delivery"),
                content: Container(
                  height: 1,
                  width: 1,
                ),
              ),
              Step(
                title: Text("Arriving today"),
                content: Container(
                  height: 1,
                  width: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List month = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
