import 'package:flutter/material.dart';
import '../homepage/homepage.dart';
import '../login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splsh_screen2 extends StatefulWidget {
  @override
  _splsh_screen2State createState() => _splsh_screen2State();
}

class _splsh_screen2State extends State<splsh_screen2> {
  PageController _pageController = PageController();
  int i = 0;
  int a = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcfdff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: PageView(
                reverse: false,

                /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                /// Use [Axis.vertical] to scroll vertically.
                controller: _pageController,
                // padEnds: true,

                onPageChanged: (int page) {
                  setState(() {
                    index = page;
                  });
                },
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/shopping.png'),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 250,
                            margin: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Text(
                              "Your groceries without stress",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'Shop from a wide selection of grocery items from top brands,eith over 80,000 items on our online supermarket.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/sale.png'),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 250,
                            margin: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Text(
                              "Amazing Discounts & Offers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'Cheapar prices than your local supermarket,great discounts and cashback offers to top it off',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/cart.png'),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 250,
                            margin: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Text(
                              "Order Your Grocery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'Quickly search and add healthy foods to your cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/delivery.png'),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 250,
                            margin: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Text(
                              "Speedy Doorstep Delivery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.symmetric(
                            horizontal: 35,
                          ),
                          child: Text(
                            'Guaranteed same day delivery of groceries in lagos and abuja. You can also pay on delivery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //     PageView.builder(
              //   controller: _pageController,
              //   itemCount: ImgesList.length,
              //   itemBuilder: (context, index) {
              //     for (int i = 0; i < ImgesList.length; i++) {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Image.asset(ImgesList[i].image),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           Container(
              //               width: 250,
              //               margin: EdgeInsets.symmetric(
              //                 horizontal: 35,
              //               ),
              //               child: Text(
              //                 ImgesList[i].name,
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 20,
              //                     color: Colors.green),
              //               )),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Container(
              //               width: 250,
              //               margin: EdgeInsets.symmetric(
              //                 horizontal: 35,
              //               ),
              //               child: Text(
              //                 ImgesList[i].details,
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w400, fontSize: 15),
              //               )),
              //         ],
              //       );
              //     }
              //     return Container();
              //   },
              // )
              // ListView.builder(
              //   itemCount: 1,
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return
              //   },
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
              ),
              Container(
                height: 12,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: ImgesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int a) {
                          return (index == a)
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                )
                              : Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    (index <= 2) ? index++ : null;
                  });
                },
                child: (index >= 3)
                    ? GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pushAndRemoveUntil(
                              (MaterialPageRoute(
                                  builder: (context) => Login())),
                              (route) => false);
                        },
                        child: Text(
                          "START",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green),
                        ),
                      )
                    : Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Images {
  String image;
  String name;
  String details;

  Images({required this.image, required this.name, required this.details});
}

List<Images> ImgesList = [
  Images(
      image: "assets/images/shopping.png",
      name: "Your groceries without stress",
      details:
          "Shop from a wide selection of grocery items from top brands,eith over 80,000 items on our online supermarket."),
  Images(
      image: "assets/images/sale.png",
      name: "Amazing Discounts & Offers",
      details:
          "Cheapar prices than your local supermarket,great discounts and cashback offers to top it off"),
  Images(
      image: "assets/images/cart.png",
      name: "Order Your Grocery",
      details: "Quickly search and add healthy foods to your cart"),
  Images(
      image: "assets/images/delivery.png",
      name: "Speedy Doorstep Delivery",
      details:
          "Guaranteed same day delivery of groceries in lagos and abuja. You can also pay on delivery"),
];
