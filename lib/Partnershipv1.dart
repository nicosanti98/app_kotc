import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'OtherPartnershipInfo.dart';
import 'PartnerDetail.dart';




class ProvaPartnership extends StatefulWidget {

  getPartnership()
  {
    return this;
  }




  @override
  ProvaPartnershipState createState() => ProvaPartnershipState();

}

class ProvaPartnershipState extends State<ProvaPartnership>{

  List<Map<String, String>> sponsorTOP = [];
  List<Map<String, String>> sponsorMEDIUM = [];
  List<Map<String, String>> sponsorDOWN = [];


  static const GOLD = 300;
  static const SILVER = 200;

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  Future<String>getSponsor() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getSponsor.php");
    var response = await http.get(uri);
    print (response.body);
    return (response.body);
  }

  count(int priorita, List<dynamic> json)
  {
    int j = 0;
    for(int i = 0; i < json.length; i++)
      {
        if(json.elementAt(i)['priorita'] == priorita)
          {
            j++;
          }
      }
    return j;
  }

 



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSponsor(),
      builder: (context, AsyncSnapshot<String>snapshot){
        if(snapshot.hasData)
          {
            sponsorTOP.removeRange(0,sponsorTOP.length);
            sponsorMEDIUM.removeRange(0, sponsorMEDIUM.length);
            sponsorDOWN.removeRange(0, sponsorDOWN.length);
            var json = jsonDecode(snapshot.data) as List;
            for(int i = 0; i < json.length; i++)
              {
                if(json.elementAt(i)['priorita'] == '1')
                  {
                    Map<String, String> item = new Map();
                    item['immagine'] = json.elementAt(i)['immagine'];
                    item['link'] = json.elementAt(i)['link'];
                    item['descrizione'] = json.elementAt(i)['descrizione'];
                    item['nome'] = json.elementAt(i)['nome'];
                    item['lat'] = json.elementAt(i)['lat'];
                    item['lng']= json.elementAt(i)['lng'];
                    sponsorTOP.add(item);
                  }
                else if (json.elementAt(i)['priorita'] == '2')
                  {
                    Map<String, String> item = new Map();
                    item['immagine'] = json.elementAt(i)['immagine'];
                    item['link'] = json.elementAt(i)['link'];
                    item['descrizione'] = json.elementAt(i)['descrizione'];
                    item['nome'] = json.elementAt(i)['nome'];
                    item['lat'] = json.elementAt(i)['lat'];
                    item['lng']= json.elementAt(i)['lng'];
                    sponsorMEDIUM.add(item);

                  }
                else if (json.elementAt(i)['priorita'] == '3')
                  {
                    Map<String, String> item = new Map();
                    item['immagine'] = json.elementAt(i)['immagine'];
                    item['link'] = json.elementAt(i)['link'];
                    item['nome'] = json.elementAt(i)['nome'];
                    item['descrizione'] = json.elementAt(i)['descrizione'];
                    item['lat'] = json.elementAt(i)['lat'];
                    item['lng']= json.elementAt(i)['lng'];
                    sponsorDOWN.add(item);
                  }
              }
            sponsorTOP = shuffle(sponsorTOP);
            sponsorMEDIUM=shuffle(sponsorMEDIUM);
            sponsorDOWN=shuffle(sponsorDOWN);
            return RefreshIndicator(
                onRefresh: (){
              setState(() {

              });
              return Future.delayed(Duration.zero) ;

            },
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  heroTag: "1",
                  backgroundColor: Colors.blue,
                  tooltip: "Diventa nostro Partner",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => OtherPartnershipInfo()));
                  },
                  child: Icon(Icons.article_outlined, color: Colors.white,),
                ),
                body: ListView(
                    children:[
                      Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text("Partnership", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1), textAlign: TextAlign.left,),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Divider(
                          color: Colors.orange,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "KING",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1), textAlign: TextAlign.center,

                        ),
                      ),
                      Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              aspectRatio: 1/1,
                              enlargeCenterPage: false,
                              viewportFraction: 0.7,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 7),
                              autoPlayAnimationDuration: Duration(seconds: 3),
                              initialPage: 0,
                              autoPlay: true,
                            ),
                            items: returnImgs(sponsorTOP),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "BASE",
                          style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1), textAlign: TextAlign.left,

                        ),
                      ),
                      Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              viewportFraction: 0.5,
                              autoPlayAnimationDuration: Duration(seconds: 2, milliseconds: 500),
                              enableInfiniteScroll: false,

                              initialPage: 0,
                              autoPlay: true,
                            ),
                            items: returnImgs(sponsorMEDIUM),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "LITE",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1), textAlign: TextAlign.left,

                        ),
                      ),
                      Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 100,
                              enlargeCenterPage: false,
                              viewportFraction: 0.3,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 500),
                              autoPlayInterval: Duration(seconds: 2),
                              initialPage: 0,
                              autoPlay: true,
                            ),
                            items: returnImgs(sponsorDOWN),
                          )
                      ),
                    ]
                ),
              ));
        }
        else
          {
            return Center(child: CircularProgressIndicator());
          }
      },
    );
  }
  
  
  
  
  
  
  returnImgs(List<Map<String, String>> list)
  {
    List<Widget> imageSliders;
    if (list == sponsorTOP)
      {
        imageSliders = list.map((item) => Container(
            child:
                Card(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:InkWell(
                        onTap: ()async{
                          var url = item['link'];
                          if (await canLaunch(url))
                            await launch(url);
                          else
                            // can't launch url, there is some error
                            throw "Could not launch $url";
                        },
                        splashColor: Colors.orange,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child:
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      child: Image.network(item['immagine'], fit: BoxFit.cover, width:1000,),
                                    ),

                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 50,
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child:FloatingActionButton(onPressed: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                builder: (context) => PartnerDetail(item['nome'],item['descrizione'], LatLng(double.parse(item['lat']), double.parse(item['lng'])), item['immagine'])));
                                            },

                                            backgroundColor: Colors.orangeAccent,
                                            child: Icon(Icons.more_horiz, color: Colors.black38,),
                                          ),
                                        )
                                    )

                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 5),

                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(item['nome']==null?"null":item['nome'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text((item['descrizione']==null?"Descrizione non disponibile":(item['descrizione'].length < 300?item['descrizione']:item['descrizione'].substring(0, 300)))
                                    ,textAlign: TextAlign.left,
                                  ),
                            )
                          ],
                        )

                    ),
                ),
            )).toList();
      }
    else if (list == sponsorMEDIUM)
      {
        imageSliders = list.map((item) => Container(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child:InkWell(
                  onTap: ()async{
                    var url = item['link'];
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                  splashColor: Colors.orange,
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(item['immagine'], fit: BoxFit.cover, width: 500),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepOrangeAccent, Colors.orangeAccent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Text(item['nome']==null?"null":item['nome'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                )
            ))).toList();
      }
    else if(list == sponsorDOWN)
      {
        imageSliders = list.map((item) => Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
                child:InkWell(
                  onTap: ()async{
                    var url = item['link'];
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                  splashColor: Colors.orange,
                  child: Container(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Image.network(item['immagine'], fit: BoxFit.cover, width: 300),
                            )
                          ],

                    ),
                  ),
                )
            ))).toList();
      }

    
    return imageSliders;
  }

}