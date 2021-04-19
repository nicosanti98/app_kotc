
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

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
      bottomSheet: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height/2.5,
          child: Container(

            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(

              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ecco come puoi contattarci",style: TextStyle(fontFamily: "roboto",
                      fontSize: 22, letterSpacing: 1), textAlign: TextAlign.left,),
                  SizedBox(height: 20,),
                  Text("Per rimanere aggiornato sulle novità seguici su Facebook e Instgram, se, invece, hai bisogno di aiuto puoi tranquillamente inviarci una mail.",
                  style: TextStyle(fontSize: 14, letterSpacing:1 ),)
               ],
              ),

          ),
            SizedBox( height: 50),
            Container(
              height: MediaQuery.of(context).size.height/10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children:[

                    FlatButton(
                      onPressed: ()async{
                        const url = "https://www.facebook.com/kingofthecagesenigallia";
                        if (await canLaunch(url))
                          await launch(url);
                        else
                        // can't launch url, there is some error
                        throw "Could not launch $url";
                      },
                      child: Image (image: AssetImage('res/fb.png'),),),
                    FlatButton(
                      onPressed: ()async{
                        const url = "instagram://user?username=kingofthecageofficial";
                        if (await canLaunch(url))
                          await launch(url);
                        else
                          // can't launch url, there is some error
                          throw "Could not launch $url";
                      },
                      child: Image (image: AssetImage('res/insta.png'),),),
                    FlatButton(
                      onPressed: ()async{
                        const url = "mailto:info@kingofthecage.it";
                        if (await canLaunch(url))
                          await launch(url);
                        else
                          // can't launch url, there is some error
                          throw "Could not launch $url";
                      },
                      child: Image (image: AssetImage('res/mail.png'),),),
                  ]

              ),

            ),


            SizedBox(height: 100,),
            ],
        )
      )
    );

  }

}