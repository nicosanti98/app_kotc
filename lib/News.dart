
import 'dart:convert';
import 'dart:io';

import 'package:app_kotc/NewsDetail.dart';
import 'package:app_kotc/NonDisponibile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_api/wordpress_api.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {

  getNews() {
    return this;
  }


  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News>{


  Future<String>getArticles() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getArticles.php");
    var response = await http.get(uri);
    return (response.body);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<String>(
      future: getArticles(),
      builder: (context, AsyncSnapshot<String> snapshot){
        if (snapshot.hasData)
          {
            var json = jsonDecode(snapshot.data);
            var jsondata = new List.from(json as List).reversed;
            var len = jsondata.length;


            return RefreshIndicator(
                onRefresh: (){
                    setState(() {

                    });
              return Future.delayed(Duration(seconds: 0)) ;

                },
                child: Scaffold(
                  backgroundColor: Colors.white,

                  body: Column(
                    children: [
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
                              child: Text("News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                            ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Divider(
                            color: Color.fromARGB(255, 244, 156, 49)
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height-114,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: len,
                            padding: EdgeInsets.all(20),
                          itemBuilder: (BuildContext context, int index){
                              return InkWell(onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetail(jsondata.elementAt(index)["post_title"].toString(), jsondata.elementAt(index)["post_content"].toString())));
                              },
                                focusColor: Colors.orange,
                                splashColor: Colors.orange,

                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width:MediaQuery.of(context).size.width-80,
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child:Text(jsondata.elementAt(index)['post_title'], textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),) ,
                                                  ),
                                                  Html(data:(jsondata.elementAt(index)['post_content'].toString().length<200)?jsondata.elementAt(index)['post_content'].toString():
                                                  jsondata.elementAt(index)['post_content'].toString().substring(0,200)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Icon(Platform.isAndroid?Icons.arrow_forward:Icons.arrow_forward_ios),
                                            )


                                          ],
                                        ),
                                        Divider(
                                            color:  Color.fromARGB(255, 244, 156, 49),
                                          ),
                                      ],
                                    )

                                ),
                              );
                          },
                        )
                        ),


                    ],
                  )
                )
            );
          }
        else
          {
            return Center(child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ), );
          }
      },
    );

  }
}