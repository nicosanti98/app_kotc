//Dichiaro la home page come widget affinchè possa ritornarlo nella classe
//princiapale

import 'dart:ui';

import 'package:app_kotc/NonDisponibile.dart';
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
  var endTime = DateTime.utc(2021, 7, 8,15,0).millisecondsSinceEpoch;

  getHomePage()
  {
    return this;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: Container(
          height: MediaQuery.of(context).size.height/10,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
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
                FlatButton(
                  child: Image(image:AssetImage('res/comune.png')) ,
                  onPressed: ()async {
                    var url = "http://www.comune.senigallia.an.it/site/senigallia/live/taxonomy/";
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                  },
                )
                


              ],
            )
        ),
        body: Container(

          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: CustomPaint(
                  painter: OpenPainter(context),
                  willChange: false,
                  child: CountdownTimer(endTime: endTime,
                    onEnd: (){
                      return countDownEnd(context);
                    },
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      if(time == null)
                      {
                        return countDownEnd(context);
                      }
                      else
                      {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/5),
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
                                        style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white),),
                                      Text("Days", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.hours==null?"0":time.hours.toString() ,
                                        style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white,),),
                                      Text("Hours", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.min==null?"0":time.min.toString() ,
                                        style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white),),
                                      Text("Minutes", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.black),)
                                    ],
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    children: <Widget>[
                                      Text(time.sec==null?"0":time.sec.toString(),
                                        style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white), ),
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
            ],
          ),
        ),
      );


  }
  Widget countownEnd(BuildContext context)
  {
    return GridView.count(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height/8, 20, 0),
      children: [
        Container(color: Colors.black54,),
        Container(color: Colors.black54)
      ],

    );

  }
  //Widget da ritornare alla fine del countdown
  Widget countDownEnd(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height/8, 20, 0),
      child:Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/10,
                      width: (MediaQuery.of(context).size.width-50)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                        gradient: LinearGradient(begin:AlignmentDirectional.topStart, end: AlignmentDirectional.bottomEnd,colors: [Colors.orange, Colors.orange.shade200]),
                      ),
                      child:
                      TextButton(
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:Text("News", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                        textAlign: TextAlign.left,)
                                  ),
                                ),

                              ],

                            ),
                          ],
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
                      height: MediaQuery.of(context).size.height/10,
                      width: (MediaQuery.of(context).size.width-50)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                        gradient: LinearGradient(begin:AlignmentDirectional.bottomEnd, end: AlignmentDirectional.topStart,colors: [Colors.orange, Colors.orange.shade200]),
                      ),
                      child:
                      TextButton(
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:Text("Calendario", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                        textAlign: TextAlign.left,)
                                  ),
                                ),

                              ],

                            ),
                          ],
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
            SizedBox(height: MediaQuery.of(context).size.width/20,),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/10,
                      width: (MediaQuery.of(context).size.width-50)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                        gradient: LinearGradient(begin:AlignmentDirectional.topStart, end: AlignmentDirectional.bottomEnd,colors: [Colors.orange, Colors.orange.shade200]),
                      ),
                      child:
                      TextButton(
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:Text("Classifiche", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                        textAlign: TextAlign.left,)
                                  ),
                                ),

                              ],

                            ),
                          ],
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
                      height: MediaQuery.of(context).size.height/10,
                      width: (MediaQuery.of(context).size.width-50)/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                        gradient: LinearGradient(begin:AlignmentDirectional.bottomEnd, end: AlignmentDirectional.topStart,colors: [Colors.orange, Colors.orange.shade200]),
                      ),
                      child:
                      TextButton(
                        child:Row(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:Text("Shop", style: TextStyle(fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.black),
                                        textAlign: TextAlign.left,)
                                  ),
                                ),

                              ],

                            ),
                          ],
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

          ],
        ),
      )
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
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawCircle(Offset(140, -200), 400, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
