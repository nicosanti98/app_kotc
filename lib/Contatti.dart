
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;

import 'News.dart';
import 'NonDisponibile.dart';
import 'Partnershipv1.dart';

class Contacts extends StatefulWidget{

  getContacts()
  {
    return this;
  }
  @override
  ContactsState createState() => ContactsState();
  }


class ContactsState extends State<Contacts> {
  GoogleMapController mapController;
  final pos = LatLng(43.715146323947984, 13.219670999849454);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Funzione controllo connessione
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  //Funzione per inviare messaggi via mail
  _sendMessage()
  async {
    check().then((internet) async {
      if(internet != null && internet)
        {
          var url = Uri.parse("https://www.kingofthecage.it/API/KotcApp/SendMail.php");
          var response = await http.post(url, body: jsonEncode(<String, String> {'mail': _mail.text, 'subject':_oggetto.text, 'text': _corpo.text, 'cellulare': _cellulare.text}));
          if(response.statusCode == 200)
          {
            Navigator.of(context).pop();
          }
          else
            {
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Errore"),
                  content: Text("Ops! Qualcosa è andato storto. Riprova più tardi!"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: (){Navigator.of(context).pop();},
                  )
                  ],
                );
              });
            }
        }
      else
        {
          showDialog(context: context, builder: (BuildContext contextchild){
            return AlertDialog(
              title: Text("Errore di connessione"),
              content: Text("Non siamo riusciti a elaborare la richiesta! Controlla la tua connessione e riprova"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: (){Navigator.of(contextchild).pop();},
                )
              ],
            );
          });
        }
    });

  }
  _sendButton()
  {
    Vibration.vibrate(duration: 20);
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Info"),
        content: Text("Vuoi veramente inviare la richiesta?"),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  //Funzione per inviare il messaggio
                  onPressed: (){
                    _sendMessage();
                  },
                ),
                FlatButton(
                  child: Text("Annulla"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          )
        ],
      );
    });

  }
  var _corpo = TextEditingController();
  var _mail = TextEditingController();
  var _oggetto = TextEditingController();
  var _cellulare = TextEditingController();
  double _mapOpacity = 0.0;
  double _txtOpacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) => setState((){
      _mapOpacity = 1;
      _txtOpacity = 1 ;
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:FlatButton(
                        minWidth: 10,
                          onPressed:(){Navigator.of(context).pop();},
                          child: Icon(Icons.arrow_back)),

                    ),
                    Container(
                        width: MediaQuery.of(context).size.width-70,
                        child:  AutoSizeText("Contattaci", maxLines:1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, letterSpacing: 1), textAlign: TextAlign.left,),
                      ),

                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  color:  Color.fromARGB(255, 244, 156, 49),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-114,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child:Container(
                        child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: (MediaQuery.of(context).size.width-50)/2,
                                        width: (MediaQuery.of(context).size.width-50)/2,
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child:
                                        TextButton(
                                          child:Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Image(image: AssetImage('res/fb.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                                  ),

                                                  SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                                  Row(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: Container(
                                                            width: (MediaQuery.of(context).size.width-170)/2,
                                                            child: AutoSizeText("Facebook", maxLines: 1, style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                                              textAlign: TextAlign.left,),
                                                          ),
                                                      ),
                                                      Container(
                                                        child: Icon(Icons.arrow_forward, color: Colors.blue,),
                                                      )

                                                    ],
                                                  )
                                                ],
                                              )
                                          ),

                                          onPressed: ()async{
                                            const url = "https://www.facebook.com/kingofthecagesenigallia";
                                            if (await canLaunch(url))
                                              await launch(url);
                                            else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                        ),),

                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [

                                      Container(
                                        height: (MediaQuery.of(context).size.width-50)/2,
                                        width: (MediaQuery.of(context).size.width-50)/2,
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child:
                                        TextButton(
                                          child:Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Image(image: AssetImage('res/insta.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                                  ),

                                                  SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                                  Row(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: Container(
                                                            width: (MediaQuery.of(context).size.width-170)/2,
                                                            child: AutoSizeText("Instagram", maxLines: 1, style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                                              textAlign: TextAlign.left,),
                                                          )
                                                      ),
                                                      Container(
                                                        child: Icon(Icons.arrow_forward, color: Colors.purpleAccent),
                                                      )

                                                    ],
                                                  )
                                                ],
                                              )
                                          ),

                                          onPressed: ()async{
                                            const url = "https://www.instagram.com/kingofthecageofficial/";
                                            if (await canLaunch(url))
                                              await launch(url);
                                            else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                        ),),


                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.width/20,),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: (MediaQuery.of(context).size.width-50)/2,
                                        width: (MediaQuery.of(context).size.width-50)/2,
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child:
                                        TextButton(
                                          child:Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Image(image: AssetImage('res/mail.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                                  ),

                                                  SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                                  Row(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: Container(
                                                            width: (MediaQuery.of(context).size.width-170)/2,
                                                            child: AutoSizeText("Mail", maxLines: 1, style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                                              textAlign: TextAlign.left,),
                                                          )
                                                      ),
                                                      Container(
                                                        child: Icon(Icons.arrow_forward, color: Colors.green),
                                                      )

                                                    ],
                                                  ),
                                                ],
                                              )
                                          ),

                                          onPressed: ()async{
                                            const url = "mailto:info@kingofthecage.it";
                                            if (await canLaunch(url))
                                              await launch(url);
                                            else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                        ),),

                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [

                                      Container(
                                        height: (MediaQuery.of(context).size.width-50)/2,
                                        width: (MediaQuery.of(context).size.width-50)/2,
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 10))],
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child:
                                        TextButton(
                                          child:Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Image(image: AssetImage('res/web.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                                  ),

                                                  SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                                  Row(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: Container(
                                                            width: (MediaQuery.of(context).size.width-170)/2,
                                                            child: AutoSizeText("Sito", maxLines: 1, style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                                              textAlign: TextAlign.left,),
                                                          )
                                                      ),
                                                      Container(
                                                        child: Icon(Icons.arrow_forward, color: Colors.yellow.shade700),
                                                      )

                                                    ],
                                                  )
                                                ],
                                              )
                                          ),

                                          onPressed: ()async{
                                            const url = "https://www.kingofthecage.it";
                                            if (await canLaunch(url))
                                              await launch(url);
                                            else
                                              // can't launch url, there is some error
                                              throw "Could not launch $url";
                                          },
                                        ),),


                                    ],
                                  )
                                ],
                              ),

                            ]),
                      ),

                    ),
                    SizedBox(height: 30),
                    ListTile(

                      leading: Image(image: AssetImage("res/3x3fiba.png"),),
                      title: Text("Regolamento"),
                      subtitle: Text("Regolamento ufficiale FIBA 3x3"),
                      onTap: ()async {const url = "https://www.kingofthecage.it/risorse/pdf/regol_fiba3x3.pdf";
                      if (await canLaunch(url))
                        await launch(url);
                        else
                        // can't launch url, there is some error
                        throw "Could not launch $url";},

                    ),
                    SizedBox(height:20),
                    Container(

                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height/2.5,
                        child: Container(

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: GoogleMap(


                              markers: {
                                Marker(
                                    markerId: MarkerId("KOTC"),
                                    position: pos,
                                    infoWindow: InfoWindow(
                                        title: "King of the Cage",
                                        snippet: "Piazza del Duca, Senigallia (AN)"
                                    )
                                )
                              },
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                  target: pos,
                                  zoom: 13
                              )
                          ),
                        )
                    ),

                  ],
                ),
              ),


  ])
    );

  }

}