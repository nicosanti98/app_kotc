import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetail extends StatelessWidget{

  var title, html;
  NewsDetail(String title, String html)
  {
    this.title = title;
    this.html  = html;
  }
  getNewsDetail()
  {

    return this;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: Color.fromARGB(255, 244, 156, 49),
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Html(data: this.html),
        ),
      )
    );

  }

}