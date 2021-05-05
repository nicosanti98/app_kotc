//Dichiaro la home page come widget affinchè possa ritornarlo nella classe
//princiapale

import 'dart:ui';

import 'package:app_kotc/Contatti.dart';
import 'package:app_kotc/NonDisponibile.dart';
import 'package:app_kotc/Partnershipv1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:url_launcher/url_launcher.dart';

import 'News.dart';
import 'Shop.dart';

class HomePage extends StatelessWidget
{
  var endTime = DateTime.utc(2021, 7, 15,16,00).millisecondsSinceEpoch;

  getHomePage()
  {
    return this;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomPaint(
          painter: OpenPainter(context),
          willChange: false,
           child: Container(

          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: CustomPaint(
                  painter: OpenPainter(context),
                  willChange: false,
                  child: CountdownTimer(endTime: endTime,
                    onEnd: (){
                      return null;
                    },
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if(time == null)
                      {
                        return ConstrainedBox(constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width/2.5),
                          child: Opacity(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2.5,
                              child: Image(image: AssetImage("res/logoBN.png")),
                            ) ,
                            opacity: 0.5,

                          ),
                        );
                      }
                      else
                      {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.5),
                            child: Opacity(
                                child: Image(image: AssetImage("res/logoBN.png"), ),
                              opacity: 0.5,

                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(time.days==null?"0":time.days.toString(),
                                        style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold, color: Colors.white),),
                                      Text("Days", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.hours==null?"0":time.hours.toString() ,
                                        style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white,),),
                                      Text("Hours", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.min==null?"0":time.min.toString() ,
                                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),
                                      Text("Minutes", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),)
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.sec==null?"0":time.sec.toString(),
                                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white), ),
                                      Text("Seconds", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),)
                                    ],
                                  ),
                                ],

                              ),
                            ),


                          ],
                        );
                      }

                    },),
                ),
              ) ,
              countDownEnd(context),
              SizedBox(height:(MediaQuery.of(context).size.width-50)/3),
              Container(
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: FlatButton(
                          child: Image(image: AssetImage('res/3x3.png')),
                          onPressed: ()async {
                            var url = "https://www.fip.it/3x3italia/";
                            if (await canLaunch(url))
                              await launch(url);
                            else
                              // can't launch url, there is some error
                              throw "Could not launch $url";
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: FlatButton(
                          child: Image(image:AssetImage('res/comune.png')) ,
                          onPressed: ()async {
                            var url = "http://www.comune.senigallia.an.it/site/senigallia/live/taxonomy/";
                            if (await canLaunch(url))
                              await launch(url);
                            else
                              // can't launch url, there is some error
                              throw "Could not launch $url";
                          },
                        ),
                      )




                    ],
                  )
              ),

            ],
          ),
        ),
        )
      );


  }
  //Widget da ritornare alla fine del countdown
  Widget countDownEnd(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
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
                                  child: Image(image: AssetImage('res/news.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("News", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward),
                                    )

                                  ],
                                )
                              ],
                            )
                        ),

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => News()));
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
                                  child: Image(image: AssetImage('res/shop.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Shop", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward, color: Colors.blue),
                                    )

                                  ],
                                )
                              ],
                            )
                        ),

                        onPressed: ()async{
                          const url = "https://www.kingofthecage.it/store";
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
                                  child: Image(image: AssetImage('res/partner.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Sponsor", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward, color: Colors.yellow.shade700),
                                    )

                                  ],
                                ),
                              ],
                            )
                        ),

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => ProvaPartnership()));
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
                                  child: Image(image: AssetImage('res/contatti.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Contatti", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
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
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => Contacts()));
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
                                  child: Image(image: AssetImage('res/calendario.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Calendario", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward, color: Colors.red),
                                    )

                                  ],
                                )
                              ],
                            )
                        ),

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => NonDisponibile()));
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
                        child:
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Image(image: AssetImage('res/podio.png'), width: (MediaQuery.of(context).size.width-50)/5),
                                ),

                                SizedBox(height:(MediaQuery.of(context).size.width-50)/10),
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text("Classifiche", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                          textAlign: TextAlign.left,)
                                    ),
                                    Container(
                                      child: Icon(Icons.arrow_forward, color: Colors.green,),
                                    )

                                  ],
                                )
                              ],
                            )
                        ),

                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => NonDisponibile()));
                        },
                      ),),

                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}

class OpenPainter extends CustomPainter{
  var context;
  OpenPainter(BuildContext context)
  {
    this.context = context;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromARGB(255, 244, 156, 49)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(-100,-100) & Size(MediaQuery.of(context).size.width*2, MediaQuery.of(context).size.height/1.5), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
