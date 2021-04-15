//Dichiaro la home page come widget affinchè possa ritornarlo nella classe
//princiapale

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';

class HomePage extends StatelessWidget
{
  var endTime = DateTime.utc(2021, 7, 1).millisecondsSinceEpoch;

  getHomePage()
  {
    return this;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                child: CountdownTimer(endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(time.days.toString(),
                                    style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white),),
                                  Text("Days", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.yellow),),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: <Widget>[
                                  Text(time.hours.toString() ,
                                    style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white,),),
                                  Text("Hours", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.yellow),),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: <Widget>[
                                  Text(time.min.toString() ,
                                    style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white),),
                                  Text("Minutes", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.yellow),)
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: <Widget>[
                                  Text(time.sec.toString(),
                                    style: TextStyle(fontFamily: "squaremaze", fontSize: 40, color: Colors.white), ),
                                  Text("Seconds", style: TextStyle(fontFamily: "roboto", fontStyle: FontStyle.italic, color: Colors.yellow),)
                                ],
                              ),
                            ],

                          ),
                        ),

                      ],
                    );
                  },),
              )



            ],
          ),
        ),
      );
  }

}