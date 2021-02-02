import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/FirstPage.dart';
import 'package:flutter_app/SecondPage.dart';
import 'package:flutter_app/third_page.dart';

final routes = <String, WidgetBuilder>{
  routeList.elementAt(0): (BuildContext context) =>
      MyHomePage(title: 'Counter Page'),
  routeList.elementAt(1): (BuildContext context) =>
      MySecondPage(title: 'Promotions'),
  routeList.elementAt(2): (BuildContext context) =>
      MyThirdPage(title: 'Table View')
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
