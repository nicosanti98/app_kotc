//Dichiaro la home page come widget affinchè possa ritornarlo nella classe
//princiapale

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:url_launcher/url_launcher.dart';

import 'News.dart';

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
          color: Colors.white,
          child: Container(
            child: Row(
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
        ),
        body: Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height/20),
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
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(time.days==null?"0":time.days.toString(),
                                      style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.orange),),
                                    Text("Days", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.orangeAccent),),
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  children: <Widget>[
                                    Text(time.hours==null?"0":time.hours.toString() ,
                                      style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.orange,),),
                                    Text("Hours", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.orangeAccent),),
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  children: <Widget>[
                                    Text(time.min==null?"0":time.min.toString() ,
                                      style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.orange),),
                                    Text("Minutes", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.orangeAccent),)
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  children: <Widget>[
                                    Text(time.sec==null?"0":time.sec.toString(),
                                      style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.orange), ),
                                    Text("Seconds", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.orangeAccent),)
                                  ],
                                ),
                              ],

                            ),
                          ),


                        ],
                      );
                    }

                  },),
              ) ,
              countDownEnd(context),
            ],
          ),
        ),
      );


  }
  //Widget da ritornare alla fine del countdown
  Widget countDownEnd(BuildContext context)
  {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
      height: MediaQuery.of(context).size.height/10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [Colors.yellow,Colors.orangeAccent, Colors.orange,]),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: TextButton(
          child:Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:Text("Vuoi rimanere sempre aggiornato?", style: TextStyle(color: Colors.black),),
                  ),
                  Align(alignment: Alignment.centerRight, child: Icon(Icons.article_outlined, color: Colors.black,),)

                ],
              ),
              Row(
                children: [
                  Container(
                    child:Text("Accedi alla sezione News", style: TextStyle(color: Colors.black),),
                  )

                ],
              ),
            ],
          ),

          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => News()));
          },
        ) ,

      )
        );
  }

}
