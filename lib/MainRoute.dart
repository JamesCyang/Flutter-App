import 'package:flutter/material.dart';
import 'package:flutter_app/FirstPage.dart';
import 'package:flutter_app/SecondPage.dart';
final routes = <String,WidgetBuilder>{
  routeList.elementAt(0):(BuildContext context) => MyHomePage(title: 'Counter Page'),
  routeList.elementAt(1):(BuildContext context) => MySecondPage(title: 'Promotions')
};
final routeList = [
  '/home', '/second'
];
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


