import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_phone_auth_page.dart';
import 'package:flutter_app/my_home_page.dart';
import 'package:flutter_app/api_call_page.dart';
import 'package:flutter_app/role_permission_page.dart';

final routes = <String, WidgetBuilder>{
  routeList.elementAt(0): (BuildContext context) =>
      MyHomePage(title: 'Counter Page'),
  routeList.elementAt(1): (BuildContext context) =>
      MySecondPage(title: 'Promotions'),
  routeList.elementAt(2): (BuildContext context) =>
      MyThirdPage(title: 'Table View'),
  routeList.elementAt(3): (BuildContext context) =>
      FirebasePhoneAuth(title: 'Authentication'),
};
final routeList = ['/home', '/second', '/third'];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp");
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Counter Page'),
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
