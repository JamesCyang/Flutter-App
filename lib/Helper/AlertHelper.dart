import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

normalAlertMessage(String sample,
    {@required String title,
    @required String buttonText1,
    @required dynamic buttonAction1,
    String buttonText2 = "",
    dynamic buttonAction2,
    bool closed}) {
  return AlertDialog(title: Text('$title'), actions: <Widget>[
    TextButton(onPressed: buttonAction1, child: Text('$buttonText1')),
    (buttonText2 == "" && buttonAction2 != null)
        ? TextButton(onPressed: buttonAction2, child: Text('$buttonText2'))
        : null
  ]);
}