import 'package:flutter/material.dart';
import 'package:grocery_app/routes/routes.dart';
import 'Page/splash_screen/splash_screen.dart';
import 'Page/splash_screen/splash_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Page/homepage/homepage.dart';
import 'constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool visit = preferences.getBool('counter') ?? false;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: colors.appcolor,
          primaryColor: colors.appcolor,
          primarySwatch: Colors.green,
          fontFamily: 'Regular'),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      // routes: {
      //   "/":(context)=> Routes.homePage;
      //
      // },
      onGenerateRoute: Routes.onRouteGenerate,
    );
  }
}
