import 'package:flutter/material.dart';
import 'package:grocery_app/Page/homepage/homepage.dart';
import 'package:grocery_app/Page/homepage/page/cart.dart';
import 'package:grocery_app/Page/homepage/page/favorite.dart';
import 'package:grocery_app/Page/homepage/page/home.dart';
import '../Page/login/login.dart';
import '../Page/signup/signup.dart';
import '../Page/splash_screen/splash_screen.dart';
import '../Page/splash_screen/splash_screen2.dart';
import 'package:grocery_app/components/common_appbar.dart';
import 'package:grocery_app/components/custom_drawer.dart';

import '../main.dart';

class Routes {
  static const String myapp = "myapp";
  static const String homePage = "/homePage";
  static const String login = "login";
  static const String signup = "signup";
  static const String splash = "splash";
  static const String splash2 = "splash2";
  static const String home = "home";
  static const String favorite = "favorite";
  static const String cart = "cart";
  static const String commonappbar = "appbar";
  static const String commonbottombar = "bottombar";
  static const String customdrawer = "drawer";

  static Route<dynamic> onRouteGenerate(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      Widget page;
      switch (settings.name) {
        case Routes.myapp:
          page = MyApp();
          break;
        case Routes.homePage:
          page = HomePage();
          break;
        case Routes.login:
          page = Login();
          break;
        case Routes.signup:
          page = SignUp();
          break;
        case Routes.splash:
          page = splash_screen();
          break;
        case Routes.splash2:
          page = splsh_screen2();
          break;
        case Routes.home:
          page = Home();
          break;
        case Routes.cart:
          page = Cart();
          break;
        case Routes.favorite:
          page = Favorite();
          break;
        case Routes.commonappbar:
          page = CommonAppbar();
          break;
        // case Routes.commonbottombar:
        //   page = CommonB();
        //   break;
        case Routes.customdrawer:
          page = CustomDrawer();
          break;
        default:
          page = Container(
            child: Text('no route'),
          );
      }
      return page;
    });
  }
}
