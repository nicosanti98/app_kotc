
import 'dart:convert';

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
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child:FlatButton(
                                minWidth: 10,
                                  onPressed:(){Navigator.of(context).pop();},
                                  child: Icon(Icons.arrow_back)),

                            ),
                            Text("News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Divider(
                            color: Color.fromARGB(255, 244, 156, 49)
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height-100,
                        child:  ListView.builder(
                            itemCount:len,
                            padding: EdgeInsets.all(20),
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                child: Column(
                                  children: [

                                    Container(
                                      child: Card(
                                        child:InkWell(
                                            onTap: (){
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => NewsDetail(jsondata.elementAt(index)["post_title"].toString(), jsondata.elementAt(index)["post_content"].toString())));
                                            },
                                            splashColor: Color.fromARGB(255, 244, 156, 49),
                                            child:Padding(
                                              padding: EdgeInsets.all(10),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minHeight: MediaQuery.of(context).size.height/6,
                                                  maxWidth: MediaQuery.of(context).size.width- 70,
                                                ),
                                                child:Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        maxWidth: MediaQuery.of(context).size.width- 70,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(jsondata.elementAt(index)['post_title'].toString(),
                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1, color: Color.fromARGB(255, 244, 156, 49),decoration: TextDecoration.underline,
                                                                  decorationColor: Colors.deepOrange),),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.bottomCenter,
                                                            child: Divider(color: Colors.black26,),
                                                          ),

                                                          Html(data:(jsondata.elementAt(index)['post_content'].toString().length<200)?jsondata.elementAt(index)['post_content'].toString():
                                                          jsondata.elementAt(index)['post_content'].toString().substring(0,200)),
                                                          Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Icon(Icons.more_horiz_rounded),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.bottomCenter,
                                                            child: Divider(color: Colors.black26,),
                                                          ),
                                                          Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child:Text("Ultimo aggiornamento: "+jsondata.elementAt(index)['post_date'], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),)
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  ],) ,
                                              ),
                                            )
                                        ),
                                        shadowColor: Color.fromARGB(255, 244, 156, 49),

                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height/30,)
                                  ],
                                ),
                              );
                            }
                        ),
                      )

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