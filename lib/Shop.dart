import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Shop extends StatelessWidget{
  getShop()
  {
    return this;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Color.fromARGB(255, 244, 156, 49),
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebView(
        initialUrl: "https://www.kingofthecage.it/store",
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
      ),

    );
  }

}