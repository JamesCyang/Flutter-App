import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebKit extends StatefulWidget {
  WebKit({Key key, this.url, this.title}) : super(key: key);

  final String url, title;

  @override
  WebKitState createState() => WebKitState();
}

class WebKitState extends State<WebKit> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    String title = widget.title;
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
