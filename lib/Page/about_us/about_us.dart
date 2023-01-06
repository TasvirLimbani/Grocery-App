import 'package:flutter/material.dart';
import 'package:grocery_app/Page/about_us/page/privacy_policy.dart';
import 'package:grocery_app/Page/about_us/page/terms_conditions.dart';
import 'package:grocery_app/constant/colors.dart';

class AboutUs extends StatefulWidget {
  @override
  AboutUsState createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 25))
          ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Color(0xffC8E6C9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.appcolor,
        title: Text(
          "About Us",
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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: size.width * 0.04),
                child: RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/images/about.png',
                    width: 250,
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 50,
            // ),
            Expanded(
                child: ListView.builder(
                    itemCount: Aboutuslist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Team_Condition()));
                          if (index == 1)
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Privacy_policy()));
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Aboutuslist[index].icon,
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${Aboutuslist[index].name}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  )
                                ],
                              ),
                            )),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class AboutUs1 {
  Icon icon;
  String name;

  AboutUs1({required this.icon, required this.name});
}

List<AboutUs1> Aboutuslist = [
  AboutUs1(
      name: "Terms & Conditions",
      icon: Icon(
        Icons.settings_outlined,
        size: 50,
        color: Colors.green,
      )),
  AboutUs1(
      name: "Privacy & Policy",
      icon: Icon(
        Icons.security_outlined,
        size: 50,
        color: Colors.green,
      ))
];
