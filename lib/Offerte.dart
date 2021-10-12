import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'PartnerDetail.dart';

class Offerte extends StatefulWidget {

  getNews() {
    return this;
  }


  @override
  OfferteState createState() => OfferteState();
}

class OfferteState extends State<Offerte>{


  Future<String>getArticles() async {
    Uri uri = Uri.parse("https://www.kingofthecage.it/API/KotcApp/getOffers.php");
    var response = await http.get(uri);
    print(response.body);
    return (response.body);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<String>(
        future: getArticles(),
    builder: (context, AsyncSnapshot<String> snapshot){
    if (snapshot.hasData && snapshot.data != "[]")
    {
      var json = jsonDecode(snapshot.data);
      var jsondata = new List.from(json as List);
      print(jsondata);

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
                    child: Container(
                      width: MediaQuery.of(context).size.width-70,
                      child:  AutoSizeText("Le offerte dei nostri Partner", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                    ),
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
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height-114,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: jsondata.length,
                        itemBuilder: (context, index){

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child:ListTile(
                                  leading: Image.network(jsondata.elementAt(index)['immagine'], fit: BoxFit.cover,),
                                  title: AutoSizeText(jsondata.elementAt(index)['nome'] + " - "+jsondata.elementAt(index)["titolo"], style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: AutoSizeText(jsondata.elementAt(index)['descrizione']),
                                  trailing: AutoSizeText(jsondata.elementAt(index)["riservatoA"]=='t'?"TUTTI":"ATLETI"),
                                  onTap: ()
                                  {
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) =>
                                        PartnerDetail(
                                            jsondata.elementAt(index)["titolo"],
                                            jsondata.elementAt(index)['descrizione'],
                                            LatLng(double.parse(
                                                jsondata.elementAt(index)['lat']),
                                                double.parse(
                                                    jsondata.elementAt(index)['lng'])),
                                            jsondata.elementAt(index)['immagine'], jsondata.elementAt(index)['link'])));
                                  },

                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          );

                        }),
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
            body: Column(
              children: [

                Container(
                  padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
                  alignment: Alignment.topLeft,
                  child:FlatButton(
                      minWidth: 10,
                      onPressed:(){Navigator.of(context).pop();},
                      child: Icon(Icons.arrow_back)),

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height/5,
                  child: Image(image: AssetImage("res/logoBN.png"),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/100,
                ),
                Text("Offerte non disponibili.\nRiprova più tardi!", style: TextStyle(fontWeight: FontWeight.bold, color:Color.fromARGB(255, 244, 156, 49),fontSize: 20, letterSpacing: 1),textAlign: TextAlign.center,),
              ],

            ),
          ), );
        }
    }

    );}
}