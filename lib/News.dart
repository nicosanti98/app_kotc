
import 'package:app_kotc/NewsDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wordpress_api/wordpress_api.dart';

class News extends StatefulWidget {

  getNews() {
    return this;
  }


  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News>{


  Future<List<PostSchema>>getArticles() async {
    WordPressAPI api = WordPressAPI('https://www.kingofthecage.it/articoli');
    final List<PostSchema> posts = await api.getPosts();
    return (posts);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<PostSchema>>(
      future: getArticles(),
      builder: (context, AsyncSnapshot<List<PostSchema>> snapshot){
        if (snapshot.hasData)
          {

            var len = snapshot.data.length;


            return RefreshIndicator(
                onRefresh: (){
                    setState(() {

                    });
              return Future.delayed(Duration(seconds: 0)) ;

                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text("News"),
                    backgroundColor: Colors.orange,
                    leading: FlatButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  body: new ListView.builder(
                    itemCount:len,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                          elevation: 4,
                          child:InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetail(snapshot.data[index].title['rendered'].toString(),
                                                                        snapshot.data[index].content['rendered'].toString())));
                            },
                            splashColor: Colors.orange,
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
                                              child: Text(snapshot.data[index].title['rendered'].toString(),
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange,decoration: TextDecoration.overline,
                                                    decorationColor: Colors.deepOrange),),
                                            ),

                                            Html(data:snapshot.data[index].content['rendered'].toString().substring(0,200)),
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
                                                child:Text("Ultimo aggiornamento: "+snapshot.data[index].date, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),)
                                            )

                                          ],
                                        ),
                                      ),
                                    ],) ,
                                ),
                              )
                          ),
                          shadowColor: Colors.orange,

                        );
                      }
                  ),
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