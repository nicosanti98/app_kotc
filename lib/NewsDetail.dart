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

      body: Column(
        children:[
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                alignment: Alignment.topLeft,
                child:FlatButton(
                    minWidth: 10,
                    onPressed:(){Navigator.of(context).pop();},
                    child: Icon(Icons.arrow_back)),

              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(this.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
              ),
            ],
          ),

    Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height-138,
            child:ListView(
    children:[
      Html(data: this.html),
    ]
    )
          )
        ),
    ]
      )
    );

  }

}